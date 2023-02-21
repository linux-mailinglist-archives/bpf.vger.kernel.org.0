Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76F6169EB47
	for <lists+bpf@lfdr.de>; Wed, 22 Feb 2023 00:35:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjBUXe6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Feb 2023 18:34:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbjBUXe6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Feb 2023 18:34:58 -0500
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A7A2298C6
        for <bpf@vger.kernel.org>; Tue, 21 Feb 2023 15:34:56 -0800 (PST)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id F015D240757
        for <bpf@vger.kernel.org>; Wed, 22 Feb 2023 00:34:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1677022495; bh=vHBNZ/xTUOBeIDYxt7n+5w+0oDi4tAn1IryfG90vkdA=;
        h=Date:From:To:Cc:Subject:From;
        b=ZulZR+Ll4fIv0HsQCg57PqtkrgW8yGsN9Umwlcpw1QWiQJ6EAbXVCVRCu5WqiJS5K
         mtMfufnY99Nb6zk03fYOT3OmyUezptmbvvpf5FJT6K/WYJiJ3TJ0aTvS+qBW5pvM3C
         TK0lgbPMarDmip3kCuGVJoczV1n8sJQQmf/Wp6J2zF23Uqf7qLV4NvPM5h/mBTHooR
         4yvCsoH32citxdfed1FQxHp1INluZq+m6Ud5gCInYNJ2cmnkFj+DvG6++nOsB9XZqE
         bFaVugMxjXHyw4ycobjNShxcI4eEl/USIveI54yD3yPLh2jzBdMeCB3KQGFsa4voFS
         Ta1r0w3P7OtYw==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4PLwcX2yvgz6tpn;
        Wed, 22 Feb 2023 00:34:52 +0100 (CET)
Date:   Tue, 21 Feb 2023 23:34:48 +0000
From:   Daniel =?utf-8?Q?M=C3=BCller?= <deso@posteo.net>
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com
Subject: Re: [PATCH bpf-next 0/3] libbpf: Make uprobe attachment APK aware
Message-ID: <20230221233448.afjni6u5jgoh2r4n@muellerd-fedora-PC2BDTX9>
References: <20230217191908.1000004-1-deso@posteo.net>
 <de1878ef-1963-6f9d-3861-a3a6cb3ceb65@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <de1878ef-1963-6f9d-3861-a3a6cb3ceb65@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Feb 18, 2023 at 08:29:32PM +0000, Alan Maguire wrote:
> On 17/02/2023 19:19, Daniel Müller wrote:
> > On Android, APKs (android packages; zip packages with somewhat
> > prescriptive contents) are first class citizens in the system: the
> > shared objects contained in them don't exist in unpacked form on the
> > file system. Rather, they are mmaped directly from within the archive
> > and the archive is also what the kernel is aware of.
> > 
> > For users that complicates the process of attaching a uprobe to a
> > function contained in a shared object in one such APK: they'd have to
> > find the byte offset of said function from the beginning of the archive.
> > That is cumbersome to do manually and can be fragile, because various
> > changes could invalidate said offset.
> > 
> > That is why for uprobes inside ELF files (not inside an APK), commit
> > d112c9ce249b ("libbpf: Support function name-based attach uprobes") added
> > support for attaching to symbols by name. On Android, that mechanism
> > currently does not work, because this logic is not APK aware.
> > 
> > This patch set introduces first class support for attaching uprobes to
> > functions inside ELF objects contained in APKs via function names. We
> > add support for recognizing the following syntax for a binary path:
> >   <archive>!/<binary-in-archive>
> > 
> >   (e.g., /system/app/test-app.apk!/lib/arm64-v8a/libc++.so)
> > 
> > This syntax is common in the Android eco system and used by tools such
> > as simpleperf. It is also what is being proposed for bcc [0].
> > 
> > If the user provides such a binary path, we find <binary-in-archive>
> > (lib/arm64-v8a/libc++.so in the example) inside of <archive>
> > (/system/app/test-app.apk). We perform the regular ELF offset search
> > inside the binary and add that to the offset within the archive itself,
> > to retrieve the offset at which to attach the uprobe.
> > 
> 
> I have to look in a bit more depth here, but my first thought is if
> we need the APK specifics in libbpf itself? Would having additional
> uprobe opts that specify elf memory and some sort of "don't attach,
> just figure out offset" flag work? Then you could perhaps do the work
> in patch 3 outside of libbpf, calling attach once to get the
> offset within the elf (using the changes in patch 2 to support ELF
> memory), then a second time to do the attach using the offset previously
> computed.
> 
> Then you could implement the APK handling in a custom SEC() handler
> which runs based on seeing an APK path or apk_uprobe/ prefix. Is that
> approach feasible? I'm guessing there's something I'm missing, but it
> would be good to understand what that is. Thanks!

Thanks for taking a look! From what I understand what you laid out could work as
well (though the devil may be in the detail here; I am not particularly familiar
with custom SEC handlers and so unless it's being prototyped I can't say for
certain).
That being said, I am not sure I see how it is superior: it strikes me as more
complicated just from a control flow and orchestration point of view. It also
does not seem more user friendly to work with. As mentioned in the description,
the proposed syntax addition is common in the eco system. I would think that
supporting it benefits users, which in turn helps with adoption of libbpf usage
on Android systems.

Thanks,
Daniel

[...]
