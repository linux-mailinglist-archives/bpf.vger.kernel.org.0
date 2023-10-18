Return-Path: <bpf+bounces-12581-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 473637CE1D5
	for <lists+bpf@lfdr.de>; Wed, 18 Oct 2023 17:55:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CC1E1C20E29
	for <lists+bpf@lfdr.de>; Wed, 18 Oct 2023 15:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B93C3B7B4;
	Wed, 18 Oct 2023 15:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fjasle.eu header.i=@fjasle.eu header.b="TDhaXrLV"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478D83B2B5
	for <bpf@vger.kernel.org>; Wed, 18 Oct 2023 15:55:18 +0000 (UTC)
X-Greylist: delayed 325 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 18 Oct 2023 08:55:11 PDT
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EFE2118
	for <bpf@vger.kernel.org>; Wed, 18 Oct 2023 08:55:10 -0700 (PDT)
Received: from leknes.fjasle.eu ([94.134.20.103]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MsI8Y-1rgyEM38Ru-00tiyo; Wed, 18 Oct 2023 17:49:20 +0200
Received: by leknes.fjasle.eu (Postfix, from userid 1000)
	id 517AF3F8DD; Wed, 18 Oct 2023 17:49:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fjasle.eu; s=mail;
	t=1697644159; bh=OH+EicPc7UzPOZaWyDPdScV+4OFzA+p27aCYY2OdDVw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TDhaXrLVKs6Z73PEcsZiScLBFOKbK3T2aAS5GNhPUaOXRB/yHkF1npRH2+wD2qh75
	 lLuF+dJVqiXlc2iPX+mvlKhqm+VvOb2cVZasXoZ7mlDSIM42UH+CwKnWvboFOMHH5O
	 pRsRVpa5lnsARqIeuLBqMi6j1ZRBCW3oXJml9Z7s=
Date: Wed, 18 Oct 2023 17:49:19 +0200
From: Nicolas Schier <nicolas@fjasle.eu>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>, bpf@vger.kernel.org
Subject: Re: [bpf-next PATCH v2 4/4] kbuild: refactor module BTF rule
Message-ID: <ZS/+f1B049Z03ibU@fjasle.eu>
References: <20231018151950.205265-1-masahiroy@kernel.org>
 <20231018151950.205265-4-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231018151950.205265-4-masahiroy@kernel.org>
X-Provags-ID: V03:K1:B4LQ7Ajm1gUh2v3KsatjhnDxISg3jTEx6iRLsNOe1KCfA0f33Je
 k7sYIst9yV21BPxNZHntNYoCfMfBn9JJ7u7RJb1MlDLUBJRKI9QHHG/+Qdt8GrCelKyrfoT
 jAaqgNcSyA5D0JtiGfbjKZ8PsxAMMrdWescAdP2w8NPlurLEVthJ35I8ul18GzB7Jp4SHGi
 cEOs6JCOLKzpjMHCAIHZA==
UI-OutboundReport: notjunk:1;M01:P0:cngp8paycZs=;surZZaC9UaO2nesjcvMNN0nhMg9
 JMILOa9ALu39shfuK1Y3IWXFydc050DpckJ+eTs2e6knf4J1GWPrFovr1o+9/odLdAX0UhYg+
 I6QjRWS9gp+i58lAM7wjMwLBs9hs3ELINQdTUs2YGltvHViU2CuXjEtjW0WIy8qLHw8jQ4T1D
 ZAC9mwXUH6mth/UE1PG/Rf3yWzzo+6Tb3iMD2/DwHkBkrf1NltmLJbDXSMuyqHuLNdJHmzrd8
 1XQBTjjUQ8eqcV03NUgC4bPSsXBZh1SAVQE7/bkLBFAOXe5wa23O+6wvrDb0o6u/yC2aGdpc5
 AdK+99Tl4+4rwjdRKzjWe+DypSN3RYJNvRqqRUp4D12UubJv4qCSSuMAJLZ0+XJhre65P6gcl
 fzs47024l9hdP2EPpNbRSD8Px6ZvXAAtPZrzyuZ4+xJTx9Q8H1LswCleb75Zd3puPjPLKi0kJ
 8Z50+6a6Hzh9y5G8XXMi1ESFtjLPI0i8lGlwoDy0ekWn2N7vnFwtf53ROAgAkyzvmCBA95q/D
 QGWEQbpXqgf6LmMn4bR8rh/v5NovI6FtHUSOUoWDU/tJuVBo5CIU56Rw5rpM6MgH8dAfLLdcI
 iP0p3YsU0n7mrx/oyN5ImgpGtEqx3EMGklsnkguG3wd6U/IMvwfSIhFYYZIvgQo5yO7KJ9YFv
 8oF6wrf1V+h9sy3nGojTUKl8Z89fNc5tCGl1LL08nFqBm6UVADTT9VmUxDOjEnSnYTRnTIu6a
 32DaBvNiFjbYPRjVOjNLNHlhdfqu4XCzqOW+P+kQ0TlJoICV/841/i+WiLEpBk+OH9JaZG7yp
 DZ/E4HTqp6cOA4Gkg7vuEQ5qWfnA7mfi3ZEmenncdT0dlLwD62KHxTKpmxGh4jUWuUbNz5XRo
 +cuH35VCVIxukMA==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Oct 19, 2023 at 12:19:50AM +0900 Masahiro Yamada wrote:
> newer_prereqs_except and if_changed_except are ugly hacks of the
> newer-prereqs and if_changed in scripts/Kbuild.include.
> 
> Remove.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
> Changes in v2:
>   - Fix if_changed_except to if_changed

thanks

Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>



>  scripts/Makefile.modfinal | 25 ++++++-------------------
>  1 file changed, 6 insertions(+), 19 deletions(-)
> 
> diff --git a/scripts/Makefile.modfinal b/scripts/Makefile.modfinal
> index 9fd7a26e4fe9..fc07854bb7b9 100644
> --- a/scripts/Makefile.modfinal
> +++ b/scripts/Makefile.modfinal
> @@ -19,6 +19,9 @@ vmlinux :=
>  ifdef CONFIG_DEBUG_INFO_BTF_MODULES
>  ifneq ($(wildcard vmlinux),)
>  vmlinux := vmlinux
> +cmd_btf = ; \
> +	LLVM_OBJCOPY="$(OBJCOPY)" $(PAHOLE) -J $(PAHOLE_FLAGS) --btf_base vmlinux $@; \
> +	$(RESOLVE_BTFIDS) -b vmlinux $@
>  else
>  $(warning Skipping BTF generation due to unavailability of vmlinux)
>  endif
> @@ -41,27 +44,11 @@ quiet_cmd_ld_ko_o = LD [M]  $@
>        cmd_ld_ko_o +=							\
>  	$(LD) -r $(KBUILD_LDFLAGS)					\
>  		$(KBUILD_LDFLAGS_MODULE) $(LDFLAGS_MODULE)		\
> -		-T scripts/module.lds -o $@ $(filter %.o, $^)
> +		-T scripts/module.lds -o $@ $(filter %.o, $^)		\
> +	$(cmd_btf)
>  
> -quiet_cmd_btf_ko = BTF [M] $@
> -      cmd_btf_ko = 							\
> -		LLVM_OBJCOPY="$(OBJCOPY)" $(PAHOLE) -J $(PAHOLE_FLAGS) --btf_base vmlinux $@; \
> -		$(RESOLVE_BTFIDS) -b vmlinux $@
> -
> -# Same as newer-prereqs, but allows to exclude specified extra dependencies
> -newer_prereqs_except = $(filter-out $(PHONY) $(1),$?)
> -
> -# Same as if_changed, but allows to exclude specified extra dependencies
> -if_changed_except = $(if $(call newer_prereqs_except,$(2))$(cmd-check),      \
> -	$(cmd);                                                              \
> -	printf '%s\n' 'savedcmd_$@ := $(make-cmd)' > $(dot-target).cmd, @:)
> -
> -# Re-generate module BTFs if either module's .ko or vmlinux changed
>  %.ko: %.o %.mod.o scripts/module.lds $(vmlinux) FORCE
> -	+$(call if_changed_except,ld_ko_o,vmlinux)
> -ifdef vmlinux
> -	+$(if $(newer-prereqs),$(call cmd,btf_ko))
> -endif
> +	+$(call if_changed,ld_ko_o)
>  
>  targets += $(modules:%.o=%.ko) $(modules:%.o=%.mod.o)
>  
> -- 
> 2.40.1

-- 
epost|xmpp: nicolas@fjasle.eu          irc://oftc.net/nsc
↳ gpg: 18ed 52db e34f 860e e9fb  c82b 7d97 0932 55a0 ce7f
     -- frykten for herren er opphav til kunnskap --

