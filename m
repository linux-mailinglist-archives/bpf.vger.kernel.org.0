Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F1265A334F
	for <lists+bpf@lfdr.de>; Sat, 27 Aug 2022 03:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232689AbiH0BHC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Aug 2022 21:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231181AbiH0BHB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Aug 2022 21:07:01 -0400
Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5B0D9AF4BA;
        Fri, 26 Aug 2022 18:06:59 -0700 (PDT)
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id AA43E72C90B;
        Sat, 27 Aug 2022 04:06:57 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id 915764A470D;
        Sat, 27 Aug 2022 04:06:57 +0300 (MSK)
Date:   Sat, 27 Aug 2022 04:06:57 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Yonghong Song <yhs@fb.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        dwarves@vger.kernel.org, bpf <bpf@vger.kernel.org>,
        Martin Reboredo <yakoyoku@gmail.com>
Subject: Re: pahole v1.24: FAILED: load BTF from vmlinux: Invalid argument
Message-ID: <20220827010657.53pu6zqfw4cuiab3@altlinux.org>
References: <20220825163538.vajnsv3xcpbhl47v@altlinux.org>
 <CA+JHD904e2TPpz1ybsaaqD+qMTDcueXu4nVcmotEPhxNfGN+Gw@mail.gmail.com>
 <20220825171620.cioobudss6ovyrkc@altlinux.org>
 <20220826025220.cxfwwpem2ycpvrmm@altlinux.org>
 <20220826025944.hd7htqqwljhse6ht@altlinux.org>
 <YwjQDBovX+cX/JDJ@krava>
 <800bde36-6cb2-d482-0cdb-b3d6005b41da@fb.com>
 <Ywj8VBH3Ud6493/z@krava>
 <2b8a762d-d013-c1df-1be0-29df6126f8c6@fb.com>
 <Ywkq61Lhyf11SsSa@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <Ywkq61Lhyf11SsSa@krava>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Jiri,

On Fri, Aug 26, 2022 at 10:19:55PM +0200, Jiri Olsa wrote:
> On Fri, Aug 26, 2022 at 11:53:34AM -0700, Yonghong Song wrote:
> > On 8/26/22 10:01 AM, Jiri Olsa wrote:
> > > On Fri, Aug 26, 2022 at 09:51:54AM -0700, Yonghong Song wrote:
> > > > On 8/26/22 6:52 AM, Jiri Olsa wrote:
> > > > > On Fri, Aug 26, 2022 at 05:59:44AM +0300, Vitaly Chikunov wrote:
> > > > > > On Fri, Aug 26, 2022 at 05:52:20AM +0300, Vitaly Chikunov wrote:
> > > > > > > Arnaldo,
> > > > > > > 
> > > > > > > On Thu, Aug 25, 2022 at 08:16:20PM +0300, Vitaly Chikunov wrote:
> > > > > > > > On Thu, Aug 25, 2022 at 01:47:59PM -0300, Arnaldo Carvalho de Melo wrote:
> > > > > > > > > On Thu, Aug 25, 2022, 1:35 PM Vitaly Chikunov <vt@altlinux.org> wrote:
> > > > > > > > > > 
> > > > > > > > > > I also noticed that after upgrading pahole to v1.24 kernel build (tested on
> > > > > > > > > > v5.18.19, v5.15.63, sorry for not testing on mainline) fails with:
> > > > > > > > > > 
> > > > > > > > > >       BTFIDS  vmlinux
> > > > > > > > > >     + ./tools/bpf/resolve_btfids/resolve_btfids vmlinux
> > > > > > > > > >     FAILED: load BTF from vmlinux: Invalid argument
> > > > > > > > > > 
> > > > > > > > > > Perhaps, .tmp_vmlinux.btf is generated incorrectly? Downgrading dwarves to
> > > > > > > > > > v1.23 resolves the issue.
> > > > > > > > > > 
> > > > > > > > > 
> > > > > > > > > Can you try this, from Martin Reboredo (Archlinux):
> > > > > > > > > 
> > > > > > > > > Can you try a build of the kernel or the by passing the
> > > > > > > > > --skip_encoding_btf_enum64 to scripts/pahole-flags.sh?
> > > > > > > > > 
> > > > > > > > > Here's a patch for either in tree scripts/pahole-flags.sh or
> > > > > > > > > /usr/lib/modules/5.19.3-arch1-1/build/scripts/pahole-flags.sh
> > > > > > > > 
> > > > > > > > This patch helped and kernel builds successfully after applying it.
> > > > > > > > (Didn't notice this suggestion in release discussion thread.)
> > > > > > > 
> > > > > > > Even thought it now compiles with this patch, it does not boot
> > > > > > > afterwards (in virtme-like env), witch such console messages:
> > > > > > 
> > > > > > I'm talking here about 5.15.62. Yes, proposed patch does not apply there
> > > > > > (since there is no `scripts/pahole-flags.sh`), but I updated
> > > > > > `scripts/link-vmlinux.sh` with the similar `if` to append
> > > > > > `--skip_encoding_btf_enum64` which lets then compilation pass.
> > > > > > 
> > > > > > Thanks,
> > > > > > 
> > > > > > > 
> > > > > > >     [    0.767649] Run /init as init process
> > > > > > >     [    0.770858] BPF:[593] ENUM perf_event_task_context
> > > > > > >     [    0.771262] BPF:size=4 vlen=4
> > > > > > >     [    0.771511] BPF:
> > > > > > >     [    0.771680] BPF:Invalid btf_info kind_flag
> > > > > > >     [    0.772016] BPF:
> > > > > 
> > > > > I can see the same on 5.15, it looks like the libbpf change that
> > > > > pahole is compiled with is setting the type's kflag for values < 0:
> > > > > (which is the case for perf_event_task_context enum first value)
> > > > > 
> > > > >     dffbbdc2d988 libbpf: Add enum64 parsing and new enum64 public API
> > > > > 
> > > > > but IIUC kflag should stay zero for normal enum otherwise the btf meta
> > > > > verifier screams
> > > > 
> > > > This is deliberate so we can have sign bit set properly for 32bit enum.
> > > > To avoid this behavior, the correct way is to turn off enum64 support
> > > > in pahole with flag --skip_encoding_btf_enum64.
> > > 
> > > I used that as well, it wouldn't compile without
> > > 
> > > the error is during the boot where the standard enum has kflag set
> > 
> > I just tried latest bpf-next, using pahole 1.24, with and without
> > --skip_encoding_btf_enum64. The following are BTF encoding
> > for enum perf_event_task_context.
> > 
> > enum perf_event_task_context {
> >         perf_invalid_context = -1,
> >         perf_hw_context = 0,
> >         perf_sw_context,
> >         perf_nr_task_contexts,
> > };
> > 
> > With --skip_encoding_btf_enum64:
> > [2285] ENUM 'perf_event_task_context' encoding=UNSIGNED size=4 vlen=4
> >         'perf_invalid_context' val=4294967295
> >         'perf_hw_context' val=0
> >         'perf_sw_context' val=1
> >         'perf_nr_task_contexts' val=2
> > 
> > Without --skip_encoding_btf_enum64:
> > [3786] ENUM 'perf_event_task_context' encoding=SIGNED size=4 vlen=4
> >         'perf_invalid_context' val=-1
> >         'perf_hw_context' val=0
> >         'perf_sw_context' val=1
> >         'perf_nr_task_contexts' val=2
> > 
> > encoding SIGNED means kflag = 1 and UNSIGNED is the default meaning
> > kflag = 0. So it looks okay to me. Could you try to use latest
> > bpftool to dump vmlinux BTF for your vmlinux binary?
> > 
> > Regarding the corresponding pahole enum64 support, we have
> > the following code,
> > 
> >         if (conf_load->skip_encoding_btf_enum64)
> >                 err = btf__add_enum_value(encoder->btf, name,
> > (uint32_t)value);
> >         else if (etype->size > 32)
> >                 err = btf__add_enum64_value(encoder->btf, name, value);
> >         else
> >                 err = btf__add_enum_value(encoder->btf, name, value);
> > 
> > If skip_encoding_btf_enum64 is enabled, the value will be passed
> > as '(uint32_t)value', so '__s64 value' in the parameter should be
> > a unsigned value and 'if (value < 0) ...' should not be
> > triggered if skip_encoding_btf_enum64 is enabled.
> > 
> > Jiri, could you double check your build environment?
> 
> ah right.. it's the build problem, 5.15 is missing backport of
>   9741e07ece7c kbuild: Unify options for BTF generation for vmlinux and modules
> 
> so modules BTF build does not pick up the --skip_encoding_btf_enum64,
> with the 5.15.61 extra change below I can boot the kernel properly
> 
> sorry for the noise
> 
> Vitaly, could you please try with the change below?

I just tested and after this additional change v5.15.63 kernel
started to boot successfully.

Thanks!

> 
> thanks,
> jirka
> 
> 
> ---
> diff --git a/scripts/Makefile.modfinal b/scripts/Makefile.modfinal
> index ff805777431c..47717e09000b 100644
> --- a/scripts/Makefile.modfinal
> +++ b/scripts/Makefile.modfinal
> @@ -40,7 +40,7 @@ quiet_cmd_ld_ko_o = LD [M]  $@
>  quiet_cmd_btf_ko = BTF [M] $@
>        cmd_btf_ko = 							\
>  	if [ -f vmlinux ]; then						\
> -		LLVM_OBJCOPY="$(OBJCOPY)" $(PAHOLE) -J --btf_base vmlinux $@; \
> +		LLVM_OBJCOPY="$(OBJCOPY)" $(PAHOLE) -J --skip_encoding_btf_enum64 --btf_base vmlinux $@; \
>  	else								\
>  		printf "Skipping BTF generation for %s due to unavailability of vmlinux\n" $@ 1>&2; \
>  	fi;
