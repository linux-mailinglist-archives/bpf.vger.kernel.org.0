Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8F165907E
	for <lists+bpf@lfdr.de>; Thu, 29 Dec 2022 19:39:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231226AbiL2SjZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 29 Dec 2022 13:39:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231313AbiL2SjO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 29 Dec 2022 13:39:14 -0500
X-Greylist: delayed 999 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 29 Dec 2022 10:39:12 PST
Received: from gandi.kataplop.net (gandi.kataplop.net [46.226.111.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9D2E207
        for <bpf@vger.kernel.org>; Thu, 29 Dec 2022 10:39:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kataplop.net; s=rsa1; h=Content-Type:MIME-Version:Message-ID:Date:cc:
        In-Reply-To:Subject:To:From:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:References:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=o2bLwIu302OPIxzzOb17jUDgPpigXlSAm3M0BzArS1o=; b=fEBBnRE+/XLyyzz0TLYYAzC544
        i83oKapU0FxQKpf/66xl2QinusJeo9oiJIH06VEk6PVtZI6h4OWCMClLTH0cMN6yZqlyOCm/g/iBu
        QetK6wn08HMNaypDH7jt8maSLsSV1XVWjFkI/WHzQBbpk/VLHG6ceEyN0Nr7DqexQU+w=;
Received: from [176.191.105.132] (helo=arrakis)
        by gandi.kataplop.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <dkm@kataplop.net>)
        id 1pAxXy-0006DF-NU; Thu, 29 Dec 2022 19:22:31 +0100
From:   Marc =?utf-8?Q?Poulhi=C3=A8s?= <dkm@kataplop.net>
To:     jose.marchesi@oracle.com
Subject: Re: Support for gcc
In-Reply-To: 87pmc6xzzp.fsf@oracle.com
cc:     anolasc13@gmail.com, bpf@vger.kernel.org
Date:   Thu, 29 Dec 2022 19:22:21 +0100
Message-ID: <87lemqvzmq.fsf@kataplop.net>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FAKE_REPLY_C,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


>> BTW, when I tried to use bpf-gcc in godbolt.org, I did not add any
>> additional compile options, and it reported an error:
>>
>> /opt/compiler-explorer/bpf/gcc-trunk-20221225/bpf-unknown-none/lib/gcc/bpf-unknown-none/13.0.0/../../../../bpf-unknown-none/bin/ld:
>> -pie not supported
>> collect2: error: ld returned 1 exit status
>> Compiler returned: 1
>
> Hmm, I just tried and it didn't add -pie to the command line options.  I
> think that somehow godbolt.org remembers and re-uses the settings used
> by the last user.  At least when it comes to select the cross compiler.
> Maybe it is the same with the compilation options...

Hi,

Happened to find this discussion and am taking the liberty to reply,
hope that's ok :)

Compiler-Explorer does not reuse anything from another user. It may
reuse something you've used in a previous session stored in your local
browser, but then this will show in the "Compiler Options...." text
field.

Here's my findings about this pie. By default, we only emit
assembly (so you won't see any ld error). But if you ask for linking to
a binary (Output >> Compile to binary), you will get this error:

https://godbolt.org/z/za3sbr5qn

Looks like our toolchain defaults to PIE. I'll look into that
(https://github.com/compiler-explorer/compiler-explorer/issues/4517).

You can use -fno-pie or uncheck "compile to binary" in the meantime.

Thanks,
Marc

PS: If you think you have a bug in compiler-explorer, click the "share"
menu (top right) and provide us with a link (short or full, both work,
but short will be easier to share in a mail).
