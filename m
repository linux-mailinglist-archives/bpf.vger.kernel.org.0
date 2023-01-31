Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02FD6682E11
	for <lists+bpf@lfdr.de>; Tue, 31 Jan 2023 14:35:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231585AbjAaNfm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 31 Jan 2023 08:35:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbjAaNfl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 31 Jan 2023 08:35:41 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E22C0518D2
        for <bpf@vger.kernel.org>; Tue, 31 Jan 2023 05:35:28 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id d4-20020a05600c3ac400b003db1de2aef0so10614394wms.2
        for <bpf@vger.kernel.org>; Tue, 31 Jan 2023 05:35:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qDF+o3k2lJZlIrv8XUH1iJH9CWOTdLmGNVORSGPoZs4=;
        b=BeWlU69E6iXrJqK7tEiG0z8036kBjeueg0K+phv9j9GUnu6Qk+4lM2GAJkG0fNa3Pl
         eJNvmV6BoR857Pf8G1Wci69RTtEfjYDroBfbMYuy8xrSPLaMGcqhnDMAw9yinJ6Ssi4c
         xlNC5CiI0Y1m62uj1RF4o0h6AfsZUzVBBnH+vDWfJyP76S/Pn6T+j9LyGJF+pBaDGnje
         Sumj0frv0S7+svBpmCvTv7xvAgDSiPMU6Gw6LSk97wzjIZ2QAub0jXDrVlIk3m6nL5sB
         4xM37ZG0zBcG9O8z2wRS8fM4e0W1X8tLDzA38ViAZ93XMK7fUCj0mQ8uTAIlSDKD4mIA
         fJWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qDF+o3k2lJZlIrv8XUH1iJH9CWOTdLmGNVORSGPoZs4=;
        b=OMDdfQ/+K8LR03gIAhHfozwtWK46Yd96JXOQjTa7hwzUMJORShPa8eZOUpVVbTyLE/
         3KIfFdvhjhwr5MWp1TCl/CSFESFpRbqFWFOYfhCXwY+XSy5t9XlTMkTYQ8hG2fmpplKP
         eaQYiwZ414OUWjlIq4erZPhZx3rr1IdXKBWnuInZ/U7QyOCh0vkYr9E5TR3IGdiK6DGu
         fkIbavkyHmLyaJjhzCzWgoegsq+uZIrqP0e1KDiWRF5oc5tpJC3ojHDPeeLJEXVwaKm0
         jA+oMXUoY4Uax6tu6E9OqAg9uJ/6KlAAqfiUUBzCExksajs0w4FI/7Ddt6ptlqz1KKUH
         EIGw==
X-Gm-Message-State: AFqh2krvn675TGXZLpfWW8x6V0iLUqeHqwmv1FCmAr6a7sRGa2I6B3Xr
        oLS96y08acbVvMDCYY7gIX8=
X-Google-Smtp-Source: AMrXdXudW0t3ROrrg3YUuBxpfpzzPPRRd8Kt7Kd1gptVRvyvQWZkT7wl/QNBwPnmfDqmEhECr3SboQ==
X-Received: by 2002:a05:600c:538c:b0:3cf:6f4d:c259 with SMTP id hg12-20020a05600c538c00b003cf6f4dc259mr53609231wmb.39.1675172127316;
        Tue, 31 Jan 2023 05:35:27 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id j5-20020a05600c1c0500b003dc4aae4739sm13715499wms.27.2023.01.31.05.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 05:35:26 -0800 (PST)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Tue, 31 Jan 2023 14:35:24 +0100
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Alan Maguire <alan.maguire@oracle.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>, yhs@fb.com,
        ast@kernel.org, olsajiri@gmail.com, eddyz87@gmail.com,
        sinquersw@gmail.com, timo@incline.eu, daniel@iogearbox.net,
        andrii@kernel.org, songliubraving@fb.com, john.fastabend@gmail.com,
        kpsingh@chromium.org, sdf@google.com, haoluo@google.com,
        martin.lau@kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v2 dwarves 1/5] dwarves: help dwarf loader spot functions
 with optimized-out parameters
Message-ID: <Y9kZHCTir3C5o+PI@krava>
References: <1675088985-20300-1-git-send-email-alan.maguire@oracle.com>
 <1675088985-20300-2-git-send-email-alan.maguire@oracle.com>
 <Y9gOGZ20aSgsYtPP@kernel.org>
 <Y9gkS6dcXO4HWovW@kernel.org>
 <Y9gnQSUvJQ6WRx8y@kernel.org>
 <561b2e18-40b3-e04f-d72e-6007e91fd37c@oracle.com>
 <Y9hf7cgqt6BHt2dH@kernel.org>
 <Y9hpD0un8d/b+Hb+@kernel.org>
 <fe5d42d1-faad-d05e-99ad-1c2c04776950@oracle.com>
 <F9C1B7E8-7A73-49B2-A2EE-235298D260BA@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F9C1B7E8-7A73-49B2-A2EE-235298D260BA@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jan 31, 2023 at 09:33:49AM -0300, Arnaldo Carvalho de Melo wrote:
> 
> 
> On January 31, 2023 9:14:05 AM GMT-03:00, Alan Maguire <alan.maguire@oracle.com> wrote:
> >On 31/01/2023 01:04, Arnaldo Carvalho de Melo wrote:
> >> Em Mon, Jan 30, 2023 at 09:25:17PM -0300, Arnaldo Carvalho de Melo escreveu:
> >>> Em Mon, Jan 30, 2023 at 10:37:56PM +0000, Alan Maguire escreveu:
> >>>> On 30/01/2023 20:23, Arnaldo Carvalho de Melo wrote:
> >>>>> Em Mon, Jan 30, 2023 at 05:10:51PM -0300, Arnaldo Carvalho de Melo escreveu:
> >>>>>> +++ b/dwarves.h
> >>>>>> @@ -262,6 +262,7 @@ struct cu {
> >>>>>>  	uint8_t		 has_addr_info:1;
> >>>>>>  	uint8_t		 uses_global_strings:1;
> >>>>>>  	uint8_t		 little_endian:1;
> >>>>>> +	uint8_t		 nr_register_params;
> >>>>>>  	uint16_t	 language;
> >>>>>>  	unsigned long	 nr_inline_expansions;
> >>>>>>  	size_t		 size_inline_expansions;
> >>>>>
> >>>  
> >>>> Thanks for this, never thought of cross-builds to be honest!
> >>>
> >>>> Tested just now on x86_64 and aarch64 at my end, just ran
> >>>> into one small thing on one system; turns out EM_RISCV isn't
> >>>> defined if using a very old elf.h; below works around this
> >>>> (dwarves otherwise builds fine on this system).
> >>>
> >>> Ok, will add it and will test with containers for older distros too.
> >> 
> >> Its on the 'next' branch, so that it gets tested in the libbpf github
> >> repo at:
> >> 
> >> https://github.com/libbpf/libbpf/actions/workflows/pahole.yml
> >> 
> >> It failed yesterday and today due to problems with the installation of
> >> llvm, probably tomorrow it'll be back working as I saw some
> >> notifications floating by.
> >> 
> >> I added the conditional EM_RISCV definition as well as removed the dup
> >> iterator that Jiri noticed.
> >>
> >
> >Thanks again Arnaldo! I've hit an issue with this series in
> >BTF encoding of kfuncs; specifically we see some kfuncs missing
> >from the BTF representation, and as a result:
> >
> >WARN: resolve_btfids: unresolved symbol bpf_xdp_metadata_rx_hash
> >WARN: resolve_btfids: unresolved symbol bpf_task_kptr_get
> >WARN: resolve_btfids: unresolved symbol bpf_ct_change_status
> >
> >Not sure why I didn't notice this previously.
> >
> >The problem is the DWARF - and therefore BTF - generated for a function like
> >
> >int bpf_xdp_metadata_rx_hash(const struct xdp_md *ctx, u32 *hash)
> >{
> >        return -EOPNOTSUPP;
> >}
> >
> >looks like this:
> >
> >   <8af83a2>   DW_AT_external    : 1
> >    <8af83a2>   DW_AT_name        : (indirect string, offset: 0x358bdc): bpf_xdp_metadata_rx_hash
> >    <8af83a6>   DW_AT_decl_file   : 5
> >    <8af83a7>   DW_AT_decl_line   : 737
> >    <8af83a9>   DW_AT_decl_column : 5
> >    <8af83aa>   DW_AT_prototyped  : 1
> >    <8af83aa>   DW_AT_type        : <0x8ad8547>
> >    <8af83ae>   DW_AT_sibling     : <0x8af83cd>
> > <2><8af83b2>: Abbrev Number: 38 (DW_TAG_formal_parameter)
> >    <8af83b3>   DW_AT_name        : ctx
> >    <8af83b7>   DW_AT_decl_file   : 5
> >    <8af83b8>   DW_AT_decl_line   : 737
> >    <8af83ba>   DW_AT_decl_column : 51
> >    <8af83bb>   DW_AT_type        : <0x8af421d>
> > <2><8af83bf>: Abbrev Number: 35 (DW_TAG_formal_parameter)
> >    <8af83c0>   DW_AT_name        : (indirect string, offset: 0x27f6a2): hash
> >    <8af83c4>   DW_AT_decl_file   : 5
> >    <8af83c5>   DW_AT_decl_line   : 737
> >    <8af83c7>   DW_AT_decl_column : 61
> >    <8af83c8>   DW_AT_type        : <0x8adc424>
> >
> >...and because there are no further abstract origin references
> >with location information either, we classify it as lacking 
> >locations for (some of) the parameters, and as a result
> >we skip BTF encoding. We can work around that by doing this:
> >
> >__attribute__ ((optimize("O0"))) int bpf_xdp_metadata_rx_hash(const struct xdp_md *ctx, u32 *hash)
> >{
> >	return -EOPNOTSUPP;
> >}
> >
> >Should we #define some kind of "kfunc" prefix equivalent to the
> >above to handle these cases in include/linux/bpf.h perhaps?
> >If that makes sense, I'll send bpf-next patches to cover the
> >set of kfuncs.
> 
> Jiri?

hum I wonder what's the point of the kfunc if it returns -EOPNOTSUPP,
at least I can't see any other version of it.. maybe some temporary
stuff like for bpf_task_kptr_get

but I think it's good idea to make sure it does not get optimized out,
so some kfunc macro seems like good idea.. or maybe we could use
also declaration tag for kfuncs

David already send some patchset for BPF_KFUNC macro, could be part of
that

https://lore.kernel.org/bpf/20230123171506.71995-1-void@manifault.com/

jirka

> 
> >The other thing we might want to do is bump the libbpf version
> >for dwarves 1.25, what do you think? I've tested with libbpf 1.1
> >and aside from the above issue all looks good (there's a few dedup
> >improvements that this version will give us). I can send a patch for
> >the libbpf update if that makes sense.
> 
> 
> Please send it, then we give it some more days of wider testing,
> 
> Yonghong, Andrii, comments on updating libbpf in the pahole submodule?
> 
> - Arnaldo
