Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBFE56B7794
	for <lists+bpf@lfdr.de>; Mon, 13 Mar 2023 13:33:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbjCMMd1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Mar 2023 08:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbjCMMd0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Mar 2023 08:33:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D000A28E90
        for <bpf@vger.kernel.org>; Mon, 13 Mar 2023 05:33:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F16AE6125D
        for <bpf@vger.kernel.org>; Mon, 13 Mar 2023 12:33:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2634FC4339B;
        Mon, 13 Mar 2023 12:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678710803;
        bh=w+HRsjbYjx9dZCjGonjhX/5DvrC0HolnD2IvxUF65H0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L7aUeZPluCiU5MSHoj0eXOrDoIl2PJ6BRZImX59fwQDlZerx77MnVd8iOBh1r4TPO
         si6jWvhA8hnWXnFYkTqi9JT65QCcRawd6lWu/n9ShsMf/x1cPTfjLpZLYmrNjlg+0Z
         P2Bd1CRRZ2sUNbHaNIqe1ha+YaR5NyQuTCajdpmSqdm9L1we8q0BlxQ+qMMACwLOcH
         6hgBQ86Wli2USuDTTrTSKgjfMoD6t6xBx9XEYzwAVjmfL0SFkXg8Pc4hmIv9zglBhx
         9MDKosmUTmP/cMXUIvEoMW5u3I0PVJtw5/P4ZE1HNfEfw/L8MJOi3ZV9tIr+nG1BgI
         cEkxlxFkVIfvA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 22CD54049F; Mon, 13 Mar 2023 09:33:20 -0300 (-03)
Date:   Mon, 13 Mar 2023 09:33:20 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Alan Maguire <alan.maguire@oracle.com>, ast@kernel.org,
        andrii@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com,
        haoluo@google.com, john.fastabend@gmail.com, kpsingh@chromium.org,
        sinquersw@gmail.com, martin.lau@kernel.org, songliubraving@fb.com,
        sdf@google.com, timo@incline.eu, yhs@fb.com, bpf@vger.kernel.org
Subject: Re: [PATCH dwarves 0/3] dwarves: improve BTF encoder comparison
 method
Message-ID: <ZA8YEHU96Tdu5Tph@kernel.org>
References: <1678459850-16140-1-git-send-email-alan.maguire@oracle.com>
 <ZA7vpa3A0IDUUL7W@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZA7vpa3A0IDUUL7W@krava>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Mon, Mar 13, 2023 at 10:40:53AM +0100, Jiri Olsa escreveu:
> On Fri, Mar 10, 2023 at 02:50:47PM +0000, Alan Maguire wrote:
> > Currently when looking for function prototype mismatches with a view
> > to excluding inconsistent functions, we fall back to a comparison
> > between parameter names when the name and number of parameters match.
> > This is brittle, as it is sometimes the case that a function has
> > multiple type-identical definitions which use different parameters.
> > 
> > Here the existing dwarves_fprintf functionality is re-used to instead
> > create a string representation of the function prototype - minus the
> > parameter names - to support a less brittle comparison method.
> > 
> > To support this, patch 1 generalizes function prototype print to
> > take a conf_fprintf parameter; this allows us to customize the
> > parameters we use in prototype string generation.
> > 
> > Patch 2 supports generating prototypes without modifiers such
> > as const as they can lead to false positive prototype mismatches;
> > see the patch for details.
> > 
> > Finally patch 3 replaces the logic used to compare parameter
> > names with the prototype string comparison instead.
> > 
> > Using verbose pahole output we can see some of the rejected
> > comparisons.  73 comparisons are rejected via prototype
> > comparison, 63 of which are non "."-suffixed functions.  For
> > example:
> > 
> > function mismatch for 'name_show'('name_show'): 'ssize_t ()(struct kobject *, struct kobj_attribute *, char *)' != 'ssize_t ()(struct device *, struct device_attribute *, char *)'
> > 
> > With these changes, the syscalls defined in sys_ni.c
> > that Jiri mentioned were missing [1] are present in BTF:
> > 
> > [43071] FUNC '__ia32_compat_sys_io_setup' type_id=42335 linkage=static
> > [43295] FUNC '__ia32_sys_io_setup' type_id=42335 linkage=static
> > [47536] FUNC '__x64_sys_io_setup' type_id=42335 linkage=static
> > 
> > [43290] FUNC '__ia32_sys_io_destroy' type_id=42335 linkage=static
> > [47531] FUNC '__x64_sys_io_destroy' type_id=42335 linkage=static
> > 
> > [43072] FUNC '__ia32_compat_sys_io_submit' type_id=42335 linkage=static
> > [43296] FUNC '__ia32_sys_io_submit' type_id=42335 linkage=static
> > [47537] FUNC '__x64_sys_io_submit' type_id=42335 linkage=static
> > 
> > [1] https://lore.kernel.org/bpf/ZAsBYpsBV0wvkhh0@krava/
> > 
> > Alan Maguire (3):
> >   dwarves_fprintf: generalize function prototype print to support
> >     passing conf
> >   dwarves_fprintf: support skipping modifier
> >   btf_encoder: compare functions via prototypes not parameter names
> 
> lgtm, the syscalls from sys_ni.c are there
> 
> for me the total number of syscalls increased from 249 to 432, great ;-)
> 
> Acked/Tested-by: Jiri Olsa <jolsa@kernel.org>
> 
> thanks,
> jirka

Thanks, applied and pushed to the 'next' branch for some more testing.

I really need to get 1.25 out of the door, due to other issue that crops
up with binutils 2.40 (DW_TAG_unspecified_type), and will be travelling
the last two days of this week, so any further testing is more than
welcome.

- Arnaldo
