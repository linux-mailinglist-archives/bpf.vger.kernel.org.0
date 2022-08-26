Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB0575A3061
	for <lists+bpf@lfdr.de>; Fri, 26 Aug 2022 22:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbiHZUUB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Aug 2022 16:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbiHZUUA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Aug 2022 16:20:00 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7603275CE;
        Fri, 26 Aug 2022 13:19:58 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id w19so5152312ejc.7;
        Fri, 26 Aug 2022 13:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc;
        bh=YEHylNod2lW4MidH7RbY0leVP5OngW2FTklyNG1hG9E=;
        b=SjDZiLN7+Zc9pDU52lPRJsJdRdSw9tChUXSy60N77MBNY0tkIKrN2EUXh8QxMJQv6x
         B0NIgBvRB+Mu6VWQ6+xSMxRUsQofYqfAD+YVvEoHDMwlrwRAmd4GivyCTmEAFLRLAHnI
         hp9p/R7jTvvFnw4FaNOqPVhzOWk/aWg1dEvyTpoWyuIqPPfjDRIdaRkR3nJmgWGww1cH
         0N4WUbvS/JmuNeZOED6pkGhuErdkoVLQnoHIpZh9Wa3houAo2fKZdUj8b23Kb8rtcXUx
         f+BfpUC/XizzoHq0fA997KH3YEuXTpZZCcsrqDuSnN88oGGp1aPCr+YCy3gsCcavnEqf
         7CLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc;
        bh=YEHylNod2lW4MidH7RbY0leVP5OngW2FTklyNG1hG9E=;
        b=5iFt2gB94wxv14uoDvEIU25a+Lb4brStpXBa8PQIOuMt/+seAeSElbWLW83SyMEM2d
         gtKsXefhJds8GXlyjTjHKcn1971T6gW9AD+40m6/LS6EjDsrYN2hiaosdf4RLzrZwIyh
         StWsnEwBbmJpqko22xc+raTolgdOrUYiEYCLXsqjy6atzDVv+z8FOcspsGWY/sh0jSDK
         v4wdOhnYFmficyGMjH5tAwPX2750astIVdxj4MDxOyCcmCNYcUZrCxAkJJ0rFTooJTeV
         7NWlRE+1tSLotnIZDWvivTuIefzBIU/XpRYS5C0ba3tgM6A8NX0RiEoCsreDEwwOvwYN
         Vwgg==
X-Gm-Message-State: ACgBeo2RIeNIEzsxyzRz1zNY2+sVeuObBaTQatSKgq9VkoXfEBhgheQa
        fYnFyxlnxem4zVTA23iAFiA=
X-Google-Smtp-Source: AA6agR72AoE0ehWiVEz5DrPHfXseSdZHyRa1VizuVrt8KDMwkk7W1K7UYPmEsMTTVhZj4oinZSct/w==
X-Received: by 2002:a17:907:e91:b0:73d:a99a:7944 with SMTP id ho17-20020a1709070e9100b0073da99a7944mr6231993ejc.216.1661545197461;
        Fri, 26 Aug 2022 13:19:57 -0700 (PDT)
Received: from krava ([83.240.62.117])
        by smtp.gmail.com with ESMTPSA id r20-20020a1709067fd400b007030c97ae62sm1248648ejs.191.2022.08.26.13.19.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 13:19:57 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Fri, 26 Aug 2022 22:19:55 +0200
To:     Yonghong Song <yhs@fb.com>
Cc:     Jiri Olsa <olsajiri@gmail.com>, Vitaly Chikunov <vt@altlinux.org>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        dwarves@vger.kernel.org, bpf <bpf@vger.kernel.org>,
        Martin Reboredo <yakoyoku@gmail.com>
Subject: Re: pahole v1.24: FAILED: load BTF from vmlinux: Invalid argument
Message-ID: <Ywkq61Lhyf11SsSa@krava>
References: <20220825163538.vajnsv3xcpbhl47v@altlinux.org>
 <CA+JHD904e2TPpz1ybsaaqD+qMTDcueXu4nVcmotEPhxNfGN+Gw@mail.gmail.com>
 <20220825171620.cioobudss6ovyrkc@altlinux.org>
 <20220826025220.cxfwwpem2ycpvrmm@altlinux.org>
 <20220826025944.hd7htqqwljhse6ht@altlinux.org>
 <YwjQDBovX+cX/JDJ@krava>
 <800bde36-6cb2-d482-0cdb-b3d6005b41da@fb.com>
 <Ywj8VBH3Ud6493/z@krava>
 <2b8a762d-d013-c1df-1be0-29df6126f8c6@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b8a762d-d013-c1df-1be0-29df6126f8c6@fb.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Aug 26, 2022 at 11:53:34AM -0700, Yonghong Song wrote:
> 
> 
> On 8/26/22 10:01 AM, Jiri Olsa wrote:
> > On Fri, Aug 26, 2022 at 09:51:54AM -0700, Yonghong Song wrote:
> > > 
> > > 
> > > On 8/26/22 6:52 AM, Jiri Olsa wrote:
> > > > On Fri, Aug 26, 2022 at 05:59:44AM +0300, Vitaly Chikunov wrote:
> > > > > On Fri, Aug 26, 2022 at 05:52:20AM +0300, Vitaly Chikunov wrote:
> > > > > > Arnaldo,
> > > > > > 
> > > > > > On Thu, Aug 25, 2022 at 08:16:20PM +0300, Vitaly Chikunov wrote:
> > > > > > > On Thu, Aug 25, 2022 at 01:47:59PM -0300, Arnaldo Carvalho de Melo wrote:
> > > > > > > > On Thu, Aug 25, 2022, 1:35 PM Vitaly Chikunov <vt@altlinux.org> wrote:
> > > > > > > > > 
> > > > > > > > > I also noticed that after upgrading pahole to v1.24 kernel build (tested on
> > > > > > > > > v5.18.19, v5.15.63, sorry for not testing on mainline) fails with:
> > > > > > > > > 
> > > > > > > > >       BTFIDS  vmlinux
> > > > > > > > >     + ./tools/bpf/resolve_btfids/resolve_btfids vmlinux
> > > > > > > > >     FAILED: load BTF from vmlinux: Invalid argument
> > > > > > > > > 
> > > > > > > > > Perhaps, .tmp_vmlinux.btf is generated incorrectly? Downgrading dwarves to
> > > > > > > > > v1.23 resolves the issue.
> > > > > > > > > 
> > > > > > > > 
> > > > > > > > Can you try this, from Martin Reboredo (Archlinux):
> > > > > > > > 
> > > > > > > > Can you try a build of the kernel or the by passing the
> > > > > > > > --skip_encoding_btf_enum64 to scripts/pahole-flags.sh?
> > > > > > > > 
> > > > > > > > Here's a patch for either in tree scripts/pahole-flags.sh or
> > > > > > > > /usr/lib/modules/5.19.3-arch1-1/build/scripts/pahole-flags.sh
> > > > > > > 
> > > > > > > This patch helped and kernel builds successfully after applying it.
> > > > > > > (Didn't notice this suggestion in release discussion thread.)
> > > > > > 
> > > > > > Even thought it now compiles with this patch, it does not boot
> > > > > > afterwards (in virtme-like env), witch such console messages:
> > > > > 
> > > > > I'm talking here about 5.15.62. Yes, proposed patch does not apply there
> > > > > (since there is no `scripts/pahole-flags.sh`), but I updated
> > > > > `scripts/link-vmlinux.sh` with the similar `if` to append
> > > > > `--skip_encoding_btf_enum64` which lets then compilation pass.
> > > > > 
> > > > > Thanks,
> > > > > 
> > > > > > 
> > > > > >     [    0.767649] Run /init as init process
> > > > > >     [    0.770858] BPF:[593] ENUM perf_event_task_context
> > > > > >     [    0.771262] BPF:size=4 vlen=4
> > > > > >     [    0.771511] BPF:
> > > > > >     [    0.771680] BPF:Invalid btf_info kind_flag
> > > > > >     [    0.772016] BPF:
> > > > 
> > > > I can see the same on 5.15, it looks like the libbpf change that
> > > > pahole is compiled with is setting the type's kflag for values < 0:
> > > > (which is the case for perf_event_task_context enum first value)
> > > > 
> > > >     dffbbdc2d988 libbpf: Add enum64 parsing and new enum64 public API
> > > > 
> > > > but IIUC kflag should stay zero for normal enum otherwise the btf meta
> > > > verifier screams
> > > 
> > > This is deliberate so we can have sign bit set properly for 32bit enum.
> > > To avoid this behavior, the correct way is to turn off enum64 support
> > > in pahole with flag --skip_encoding_btf_enum64.
> > 
> > I used that as well, it wouldn't compile without
> > 
> > the error is during the boot where the standard enum has kflag set
> 
> I just tried latest bpf-next, using pahole 1.24, with and without
> --skip_encoding_btf_enum64. The following are BTF encoding
> for enum perf_event_task_context.
> 
> enum perf_event_task_context {
>         perf_invalid_context = -1,
>         perf_hw_context = 0,
>         perf_sw_context,
>         perf_nr_task_contexts,
> };
> 
> With --skip_encoding_btf_enum64:
> [2285] ENUM 'perf_event_task_context' encoding=UNSIGNED size=4 vlen=4
>         'perf_invalid_context' val=4294967295
>         'perf_hw_context' val=0
>         'perf_sw_context' val=1
>         'perf_nr_task_contexts' val=2
> 
> Without --skip_encoding_btf_enum64:
> [3786] ENUM 'perf_event_task_context' encoding=SIGNED size=4 vlen=4
>         'perf_invalid_context' val=-1
>         'perf_hw_context' val=0
>         'perf_sw_context' val=1
>         'perf_nr_task_contexts' val=2
> 
> encoding SIGNED means kflag = 1 and UNSIGNED is the default meaning
> kflag = 0. So it looks okay to me. Could you try to use latest
> bpftool to dump vmlinux BTF for your vmlinux binary?
> 
> Regarding the corresponding pahole enum64 support, we have
> the following code,
> 
>         if (conf_load->skip_encoding_btf_enum64)
>                 err = btf__add_enum_value(encoder->btf, name,
> (uint32_t)value);
>         else if (etype->size > 32)
>                 err = btf__add_enum64_value(encoder->btf, name, value);
>         else
>                 err = btf__add_enum_value(encoder->btf, name, value);
> 
> If skip_encoding_btf_enum64 is enabled, the value will be passed
> as '(uint32_t)value', so '__s64 value' in the parameter should be
> a unsigned value and 'if (value < 0) ...' should not be
> triggered if skip_encoding_btf_enum64 is enabled.
> 
> Jiri, could you double check your build environment?

ah right.. it's the build problem, 5.15 is missing backport of
  9741e07ece7c kbuild: Unify options for BTF generation for vmlinux and modules

so modules BTF build does not pick up the --skip_encoding_btf_enum64,
with the 5.15.61 extra change below I can boot the kernel properly

sorry for the noise

Vitaly, could you please try with the change below?

thanks,
jirka


---
diff --git a/scripts/Makefile.modfinal b/scripts/Makefile.modfinal
index ff805777431c..47717e09000b 100644
--- a/scripts/Makefile.modfinal
+++ b/scripts/Makefile.modfinal
@@ -40,7 +40,7 @@ quiet_cmd_ld_ko_o = LD [M]  $@
 quiet_cmd_btf_ko = BTF [M] $@
       cmd_btf_ko = 							\
 	if [ -f vmlinux ]; then						\
-		LLVM_OBJCOPY="$(OBJCOPY)" $(PAHOLE) -J --btf_base vmlinux $@; \
+		LLVM_OBJCOPY="$(OBJCOPY)" $(PAHOLE) -J --skip_encoding_btf_enum64 --btf_base vmlinux $@; \
 	else								\
 		printf "Skipping BTF generation for %s due to unavailability of vmlinux\n" $@ 1>&2; \
 	fi;
