Return-Path: <bpf+bounces-2806-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7ABE734201
	for <lists+bpf@lfdr.de>; Sat, 17 Jun 2023 17:39:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5C481C20A8B
	for <lists+bpf@lfdr.de>; Sat, 17 Jun 2023 15:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE3ABAD53;
	Sat, 17 Jun 2023 15:39:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BA079EC
	for <bpf@vger.kernel.org>; Sat, 17 Jun 2023 15:39:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2483FC433CA
	for <bpf@vger.kernel.org>; Sat, 17 Jun 2023 15:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687016372;
	bh=yls5FG8rNuC31hxJeDEoLXC+oEyCGDZjCJ7zAyhONK4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=d+ULHEuHRomChr1h7WMOhOlI70lwBfM6vx2GwBmXtWLZtB7qc1M1FOtWxBm8Kew5y
	 Dcu4d2ECPjwHS7LCqgRAcH35N2NZrojzndzp3Q+HhsmgTRX2/EJHrq2y8WWwvYZIG9
	 P+CEeNMPeRddTR4SE6IL9Uv4HnZIrf0GXPL27rSc0pmIrSggo0ALHtJviGJe4wcsbO
	 eD3twWmh0QuZ6qjXRkoWIxraZVJGss/eAs671ofFzFwuGbSDcKqSOFQdz4xa74AZq9
	 72W1k4TKOvqeRwGpuHp4Jy3L6y6JnnaEgdtRXMN0uj6FXFGRxz8RLXmryxHkoiAu91
	 BdcLUpd9bZ9pQ==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-4f6283d0d84so2392539e87.1
        for <bpf@vger.kernel.org>; Sat, 17 Jun 2023 08:39:31 -0700 (PDT)
X-Gm-Message-State: AC+VfDwG1JTtyFgM4vpU6URveLzUx1K5pkQpsBPiTAzYcsby0Ke9rOiU
	6gNiWMA7Ib28XLNcdbMJA+H5CnmsNZD9v8Af/oefbw==
X-Google-Smtp-Source: ACHHUZ4jOngs+qGpr4MtAEWJxGeqKVeNYr9lBTv43Ss+RpMZt9t1SzYAA1/ii03ETXlbzTmwZ61naQrJodpY3MiqmiA=
X-Received: by 2002:a19:911d:0:b0:4f6:1f5a:60d6 with SMTP id
 t29-20020a19911d000000b004f61f5a60d6mr3175766lfd.44.1687016370036; Sat, 17
 Jun 2023 08:39:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230616000441.3677441-4-kpsingh@kernel.org> <202306170414.br6e1YPW-lkp@intel.com>
In-Reply-To: <202306170414.br6e1YPW-lkp@intel.com>
From: KP Singh <kpsingh@kernel.org>
Date: Sat, 17 Jun 2023 17:39:19 +0200
X-Gmail-Original-Message-ID: <CACYkzJ4d9pQECEY+pyVDO42caqVHG33jUbKw5xF4ME=66rjVgQ@mail.gmail.com>
Message-ID: <CACYkzJ4d9pQECEY+pyVDO42caqVHG33jUbKw5xF4ME=66rjVgQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] security: Replace indirect LSM hook calls with
 static calls
To: kernel test robot <lkp@intel.com>
Cc: linux-security-module@vger.kernel.org, bpf@vger.kernel.org, 
	oe-kbuild-all@lists.linux.dev, paul@paul-moore.com, keescook@chromium.org, 
	casey@schaufler-ca.com, song@kernel.org, daniel@iogearbox.net, ast@kernel.org, 
	jannh@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 16, 2023 at 11:10=E2=80=AFPM kernel test robot <lkp@intel.com> =
wrote:
>
> Hi KP,
>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on next-20230615]
> [also build test ERROR on v6.4-rc6]
> [cannot apply to bpf-next/master bpf/master pcmoore-selinux/next linus/ma=
ster v6.4-rc6 v6.4-rc5 v6.4-rc4]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/KP-Singh/kernel-Ad=
d-helper-macros-for-loop-unrolling/20230616-080708
> base:   next-20230615
> patch link:    https://lore.kernel.org/r/20230616000441.3677441-4-kpsingh=
%40kernel.org
> patch subject: [PATCH v2 3/5] security: Replace indirect LSM hook calls w=
ith static calls
> config: s390-defconfig (https://download.01.org/0day-ci/archive/20230617/=
202306170414.br6e1YPW-lkp@intel.com/config)
> compiler: s390-linux-gcc (GCC) 12.3.0
> reproduce: (https://download.01.org/0day-ci/archive/20230617/202306170414=
.br6e1YPW-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202306170414.br6e1YPW-lkp=
@intel.com/
>
> All errors (new ones prefixed by >>):
>
> >> s390-linux-ld: security/security.o:(.data..ro_after_init+0x28): undefi=
ned reference to `__SCT__lsm_static_call_binder_set_context_mgr_0'
> >> s390-linux-ld: security/security.o:(.data..ro_after_init+0x48): undefi=
ned reference to `__SCT__lsm_static_call_binder_set_context_mgr_1'
> >> s390-linux-ld: security/security.o:(.data..ro_after_init+0x68): undefi=
ned reference to `__SCT__lsm_static_call_binder_set_context_mgr_2'
> >> s390-linux-ld: security/security.o:(.data..ro_after_init+0x88): undefi=
ned reference to `__SCT__lsm_static_call_binder_set_context_mgr_3'
> >> s390-linux-ld: security/security.o:(.data..ro_after_init+0xa8): undefi=
ned reference to `__SCT__lsm_static_call_binder_set_context_mgr_4'
> >> s390-linux-ld: security/security.o:(.data..ro_after_init+0xc8): undefi=
ned reference to `__SCT__lsm_static_call_binder_transaction_0'
> >> s390-linux-ld: security/security.o:(.data..ro_after_init+0xe8): undefi=
ned reference to `__SCT__lsm_static_call_binder_transaction_1'
> >> s390-linux-ld: security/security.o:(.data..ro_after_init+0x108): undef=
ined reference to `__SCT__lsm_static_call_binder_transaction_2'
> >> s390-linux-ld: security/security.o:(.data..ro_after_init+0x128): undef=
ined reference to `__SCT__lsm_static_call_binder_transaction_3'
> >> s390-linux-ld: security/security.o:(.data..ro_after_init+0x148): undef=
ined reference to `__SCT__lsm_static_call_binder_transaction_4'
> >> s390-linux-ld: security/security.o:(.data..ro_after_init+0x168): undef=
ined reference to `__SCT__lsm_static_call_binder_transfer_binder_0'
> >> s390-linux-ld: security/security.o:(.data..ro_after_init+0x188): undef=
ined reference to `__SCT__lsm_static_call_binder_transfer_binder_1'
> >> s390-linux-ld: security/security.o:(.data..ro_after_init+0x1a8): undef=
ined reference to `__SCT__lsm_static_call_binder_transfer_binder_2'
> >> s390-linux-ld: security/security.o:(.data..ro_after_init+0x1c8): undef=
ined reference to `__SCT__lsm_static_call_binder_transfer_binder_3'
> >> s390-linux-ld: security/security.o:(.data..ro_after_init+0x1e8): undef=
ined reference to `__SCT__lsm_static_call_binder_transfer_binder_4'
> >> s390-linux-ld: security/security.o:(.data..ro_after_init+0x208): undef=
ined reference to `__SCT__lsm_static_call_binder_transfer_file_0'
> >> s390-linux-ld: security/security.o:(.data..ro_after_init+0x228): undef=
ined reference to `__SCT__lsm_static_call_binder_transfer_file_1'
> >> s390-linux-ld: security/security.o:(.data..ro_after_init+0x248): undef=
ined reference to `__SCT__lsm_static_call_binder_transfer_file_2'
> >> s390-linux-ld: security/security.o:(.data..ro_after_init+0x268): undef=
ined reference to `__SCT__lsm_static_call_binder_transfer_file_3'
> >> s390-linux-ld: security/security.o:(.data..ro_after_init+0x288): undef=
ined reference to `__SCT__lsm_static_call_binder_transfer_file_4'
>    s390-linux-ld: security/security.o:(.data..ro_after_init+0x2a8): undef=
ined reference to `__SCT__lsm_static_call_ptrace_access_check_0'
>    s390-linux-ld: security/security.o:(.data..ro_after_init+0x2c8): undef=
ined reference to `__SCT__lsm_static_call_ptrace_access_check_1'
>    s390-linux-ld: security/security.o:(.data..ro_after_init+0x2e8): undef=
ined reference to `__SCT__lsm_static_call_ptrace_access_check_2'
>    s390-linux-ld: security/security.o:(.data..ro_after_init+0x308): undef=
ined reference to `__SCT__lsm_static_call_ptrace_access_check_3'
>    s390-linux-ld: security/security.o:(.data..ro_after_init+0x328): undef=
ined reference to `__SCT__lsm_static_call_ptrace_access_check_4'
>    s390-linux-ld: security/security.o:(.data..ro_after_init+0x348): undef=
ined reference to `__SCT__lsm_static_call_ptrace_traceme_0'
>    s390-linux-ld: security/security.o:(.data..ro_after_init+0x368): undef=
ined reference to `__SCT__lsm_static_call_ptrace_traceme_1'
>    s390-linux-ld: security/security.o:(.data..ro_after_init+0x388): undef=
ined reference to `__SCT__lsm_static_call_ptrace_traceme_2'
>    s390-linux-ld: security/security.o:(.data..ro_after_init+0x3a8): undef=
ined reference to `__SCT__lsm_static_call_ptrace_traceme_3'
>    s390-linux-ld: security/security.o:(.data..ro_after_init+0x3c8): undef=
ined reference to `__SCT__lsm_static_call_ptrace_traceme_4'
>    s390-linux-ld: security/security.o:(.data..ro_after_init+0x3e8): undef=
ined reference to `__SCT__lsm_static_call_capget_0'
>    s390-linux-ld: security/security.o:(.data..ro_after_init+0x408): undef=
ined reference to `__SCT__lsm_static_call_capget_1'
>    s390-linux-ld: security/security.o:(.data..ro_after_init+0x428): undef=
ined reference to `__SCT__lsm_static_call_capget_2'
>    s390-linux-ld: security/security.o:(.data..ro_after_init+0x448): undef=
ined reference to `__SCT__lsm_static_call_capget_3'
>    s390-linux-ld: security/security.o:(.data..ro_after_init+0x468): undef=
ined reference to `__SCT__lsm_static_call_capget_4'
>    s390-linux-ld: security/security.o:(.data..ro_after_init+0x488): undef=
ined reference to `__SCT__lsm_static_call_capset_0'
>    s390-linux-ld: security/security.o:(.data..ro_after_init+0x4a8): undef=
ined reference to `__SCT__lsm_static_call_capset_1'
>    s390-linux-ld: security/security.o:(.data..ro_after_init+0x4c8): undef=
ined reference to `__SCT__lsm_static_call_capset_2'
>    s390-linux-ld: security/security.o:(.data..ro_after_init+0x4e8): undef=
ined reference to `__SCT__lsm_static_call_capset_3'
>    s390-linux-ld: security/security.o:(.data..ro_after_init+0x508): undef=
ined reference to `__SCT__lsm_static_call_capset_4'
>    s390-linux-ld: security/security.o:(.data..ro_after_init+0x528): undef=
ined reference to `__SCT__lsm_static_call_capable_0'
>    s390-linux-ld: security/security.o:(.data..ro_after_init+0x548): undef=
ined reference to `__SCT__lsm_static_call_capable_1'
>    s390-linux-ld: security/security.o:(.data..ro_after_init+0x568): undef=
ined reference to `__SCT__lsm_static_call_capable_2'
>    s390-linux-ld: security/security.o:(.data..ro_after_init+0x588): undef=
ined reference to `__SCT__lsm_static_call_capable_3'
>    s390-linux-ld: security/security.o:(.data..ro_after_init+0x5a8): undef=
ined reference to `__SCT__lsm_static_call_capable_4'
>    s390-linux-ld: security/security.o:(.data..ro_after_init+0x5c8): undef=
ined reference to `__SCT__lsm_static_call_quotactl_0'
>    s390-linux-ld: security/security.o:(.data..ro_after_init+0x5e8): undef=
ined reference to `__SCT__lsm_static_call_quotactl_1'
>    s390-linux-ld: security/security.o:(.data..ro_after_init+0x608): undef=
ined reference to `__SCT__lsm_static_call_quotactl_2'
>    s390-linux-ld: security/security.o:(.data..ro_after_init+0x628): undef=
ined reference to `__SCT__lsm_static_call_quotactl_3'
>    s390-linux-ld: security/security.o:(.data..ro_after_init+0x648): undef=
ined reference to `__SCT__lsm_static_call_quotactl_4'
>    s390-linux-ld: security/security.o:(.data..ro_after_init+0x668): undef=
ined reference to `__SCT__lsm_static_call_quota_on_0'
>    s390-linux-ld: security/security.o:(.data..ro_after_init+0x688): undef=
ined reference to `__SCT__lsm_static_call_quota_on_1'
>    s390-linux-ld: security/security.o:(.data..ro_after_init+0x6a8): undef=
ined reference to `__SCT__lsm_static_call_quota_on_2'
>    s390-linux-ld: security/security.o:(.data..ro_after_init+0x6c8): undef=
ined reference to `__SCT__lsm_static_call_quota_on_3'
>    s390-linux-ld: security/security.o:(.data..ro_after_init+0x6e8): undef=
ined reference to `__SCT__lsm_static_call_quota_on_4'
>    s390-linux-ld: security/security.o:(.data..ro_after_init+0x708): undef=
ined reference to `__SCT__lsm_static_call_syslog_0'
>    s390-linux-ld: security/security.o:(.data..ro_after_init+0x728): undef=
ined reference to `__SCT__lsm_static_call_syslog_1'
>    s390-linux-ld: security/security.o:(.data..ro_after_init+0x748): undef=
ined reference to `__SCT__lsm_static_call_syslog_2'
>    s390-linux-ld: security/security.o:(.data..ro_after_init+0x768): undef=
ined reference to `__SCT__lsm_static_call_syslog_3'
>    s390-linux-ld: security/security.o:(.data..ro_after_init+0x788): undef=
ined reference to `__SCT__lsm_static_call_syslog_4'
>    s390-linux-ld: security/security.o:(.data..ro_after_init+0x7a8): undef=
ined reference to `__SCT__lsm_static_call_settime_0'
>    s390-linux-ld: security/security.o:(.data..ro_after_init+0x7c8): undef=
ined reference to `__SCT__lsm_static_call_settime_1'
>    s390-linux-ld: security/security.o:(.data..ro_after_init+0x7e8): undef=
ined reference to `__SCT__lsm_static_call_settime_2'
>    s390-linux-ld: security/security.o:(.data..ro_after_init+0x808): undef=
ined reference to `__SCT__lsm_static_call_settime_3'
>    s390-linux-ld: security/security.o:(.data..ro_after_init+0x828): undef=
ined reference to `__SCT__lsm_static_call_settime_4'
>    s390-linux-ld: security/security.o:(.data..ro_after_init+0x848): undef=
ined reference to `__SCT__lsm_static_call_vm_enough_memory_0'
>    s390-linux-ld: security/security.o:(.data..ro_after_init+0x868): undef=
ined reference to `__SCT__lsm_static_call_vm_enough_memory_1'
>    s390-linux-ld: security/security.o:(.data..ro_after_init+0x888): undef=
ined reference to `__SCT__lsm_static_call_vm_enough_memory_2'
>    s390-linux-ld: security/security.o:(.data..ro_after_init+0x8a8): undef=
ined reference to `__SCT__lsm_static_call_vm_enough_memory_3'
>    s390-linux-ld: security/security.o:(.data..ro_after_init+0x8c8): undef=
ined reference to `__SCT__lsm_static_call_vm_enough_memory_4'
>    s390-linux-ld: security/security.o:(.data..ro_after_init+0x8e8): undef=
ined reference to `__SCT__lsm_static_call_bprm_creds_for_exec_0'
>    s390-linux-ld: security/security.o:(.data..ro_after_init+0x908): undef=
ined reference to `__SCT__lsm_static_call_bprm_creds_for_exec_1'
>    s390-linux-ld: security/security.o:(.data..ro_after_init+0x928): undef=
ined reference to `__SCT__lsm_static_call_bprm_creds_for_exec_2'
>    s390-linux-ld: security/security.o:(.data..ro_after_init+0x948): undef=
ined reference to `__SCT__lsm_static_call_bprm_creds_for_exec_3'
>    s390-linux-ld: security/security.o:(.data..ro_after_init+0x968): undef=
ined reference to `__SCT__lsm_static_call_bprm_creds_for_exec_4'
>    s390-linux-ld: security/security.o:(.data..ro_after_init+0x988): undef=
ined reference to `__SCT__lsm_static_call_bprm_creds_from_file_0'
>    s390-linux-ld: security/security.o:(.data..ro_after_init+0x9a8): undef=
ined reference to `__SCT__lsm_static_call_bprm_creds_from_file_1'
>    s390-linux-ld: security/security.o:(.data..ro_after_init+0x9c8): undef=
ined reference to `__SCT__lsm_static_call_bprm_creds_from_file_2'
>    s390-linux-ld: security/security.o:(.data..ro_after_init+0x9e8): undef=
ined reference to `__SCT__lsm_static_call_bprm_creds_from_file_3'
>    s390-linux-ld: security/security.o:(.data..ro_after_init+0xa08): undef=
ined reference to `__SCT__lsm_static_call_bprm_creds_from_file_4'
>    s390-linux-ld: security/security.o:(.data..ro_after_init+0xa28): undef=
ined reference to `__SCT__lsm_static_call_bprm_check_security_0'
>    s390-linux-ld: security/security.o:(.data..ro_after_init+0xa48): undef=
ined reference to `__SCT__lsm_static_call_bprm_check_security_1'
>    s390-linux-ld: security/security.o:(.data..ro_after_init+0xa68): undef=
ined reference to `__SCT__lsm_static_call_bprm_check_security_2'
>    s390-linux-ld: security/security.o:(.data..ro_after_init+0xa88): undef=
ined reference to `__SCT__lsm_static_call_bprm_check_security_3'
>    s390-linux-ld: security/security.o:(.data..ro_after_init+0xaa8): undef=
ined reference to `__SCT__lsm_static_call_bprm_check_security_4'
>    s390-linux-ld: security/security.o:(.data..ro_after_init+0xac8): undef=
ined reference to `__SCT__lsm_static_call_bprm_committing_creds_0'
>    s390-linux-ld: security/security.o:(.data..ro_after_init+0xae8): undef=
ined reference to `__SCT__lsm_static_call_bprm_committing_creds_1'
>    s390-linux-ld: security/security.o:(.data..ro_after_init+0xb08): undef=
ined reference to `__SCT__lsm_static_call_bprm_committing_creds_2'
>    s390-linux-ld: security/security.o:(.data..ro_after_init+0xb28): undef=
ined reference to `__SCT__lsm_static_call_bprm_committing_creds_3'
>    s390-linux-ld: security/security.o:(.data..ro_after_init+0xb48): undef=
ined reference to `__SCT__lsm_static_call_bprm_committing_creds_4'
>    s390-linux-ld: security/security.o:(.data..ro_after_init+0xb68): undef=
ined reference to `__SCT__lsm_static_call_bprm_committed_creds_0'
>    s390-linux-ld: security/security.o:(.data..ro_after_init+0xb88): undef=
ined reference to `__SCT__lsm_static_call_bprm_committed_creds_1'
>    s390-linux-ld: security/security.o:(.data..ro_after_init+0xba8): undef=
ined reference to `__SCT__lsm_static_call_bprm_committed_creds_2'
>    s390-linux-ld: security/security.o:(.data..ro_after_init+0xbc8): undef=
ined reference to `__SCT__lsm_static_call_bprm_committed_creds_3'
>    s390-linux-ld: security/security.o:(.data..ro_after_init+0xbe8): undef=
ined reference to `__SCT__lsm_static_call_bprm_committed_creds_4'
>    s390-linux-ld: security/security.o:(.data..ro_after_init+0xc08): undef=
ined reference to `__SCT__lsm_static_call_fs_context_dup_0'
>    s390-linux-ld: security/security.o:(.data..ro_after_init+0xc28): undef=
ined reference to `__SCT__lsm_static_call_fs_context_dup_1'
>    s390-linux-ld: security/security.o:(.data..ro_after_init+0xc48): undef=
ined reference to `__SCT__lsm_static_call_fs_context_dup_2'
>    s390-linux-ld: security/security.o:(.data..ro_after_init+0xc68): undef=
ined reference to `__SCT__lsm_static_call_fs_context_dup_3'
>    s390-linux-ld: security/security.o:(.data..ro_after_init+0xc88): undef=
ined reference to `__SCT__lsm_static_call_fs_context_dup_4'
>    s390-linux-ld: security/security.o:(.data..ro_after_init+0xca8): undef=
ined reference to `__SCT__lsm_static_call_fs_context_parse_param_0'
>    s390-linux-ld: security/security.o:(.data..ro_after_init+0xcc8): undef=
ined reference to `__SCT__lsm_static_call_fs_context_parse_param_1'
>    s390-linux-ld: security/security.o:(.data..ro_after_init+0xce8): undef=
ined reference to `__SCT__lsm_static_call_fs_context_parse_param_2'
>    s390-linux-ld: security/security.o:(.data..ro_after_init+0xd08): undef=
ined reference to `__SCT__lsm_static_call_fs_context_parse_param_3'
>    s390-linux-ld: security/security.o:(.data..ro_after_init+0xd28): undef=
ined reference to `__SCT__lsm_static_call_fs_context_parse_param_4'
>    s390-linux-ld: security/security.o:(.data..ro_after_init+0xd48): undef=
ined reference to `__SCT__lsm_static_call_sb_alloc_security_0'
>    s390-linux-ld: security/security.o:(.data..ro_after_init+0xd68): undef=
ined reference to `__SCT__lsm_static_call_sb_alloc_security_1'
>    s390-linux-ld: security/security.o:(.data..ro_after_init+0xd88): undef=
ined reference to `__SCT__lsm_static_call_sb_alloc_security_2'
>    s390-linux-ld: security/security.o:(.data..ro_after_init+0xda8): undef=
ined reference to `__SCT__lsm_static_call_sb_alloc_security_3'
>    s390-linux-ld: security/security.o:(.data..ro_after_init+0xdc8): undef=
ined reference to `__SCT__lsm_static_call_sb_alloc_security_4'
>    s390-linux-ld: security/security.o:(.data..ro_after_init+0xde8): undef=
ined reference to `__SCT__lsm_static_call_sb_delete_0'
>    s390-linux-ld: security/security.o:(.data..ro_after_init+0xe08): undef=
ined reference to `__SCT__lsm_static_call_sb_delete_1'
>    s390-linux-ld: security/security.o:(.data..ro_after_init+0xe28): undef=
ined reference to `__SCT__lsm_static_call_sb_delete_2'
>    s390-linux-ld: security/security.o:(.data..ro_after_init+0xe48): undef=
ined reference to `__SCT__lsm_static_call_sb_delete_3'
>    s390-linux-ld: security/security.o:(.data..ro_after_init+0xe68): undef=
ined reference to `__SCT__lsm_static_call_sb_delete_4'
>    s390-linux-ld: security/security.o:(.data..ro_after_init+0xe88): undef=
ined reference to `__SCT__lsm_static_call_sb_free_security_0'
>    s390-linux-ld: security/security.o:(.data..ro_after_init+0xea8): undef=
ined reference to `__SCT__lsm_static_call_sb_free_security_1'
>    s390-linux-ld: security/security.o:(.data..ro_after_init+0xec8): undef=
ined reference to `__SCT__lsm_static_call_sb_free_security_2'
>    s390-linux-ld: security/security.o:(.data..ro_after_init+0xee8): undef=
ined reference to `__SCT__lsm_static_call_sb_free_security_3'
>    s390-linux-ld: security/security.o:(.data..ro_after_init+0xf08): undef=
ined reference to `__SCT__lsm_static_call_sb_free_security_4'
>

We ended up leaking the STATIC_CALL_TRAMP (__SCT__) which is not used
on architectures that don't have static call support. A simple change
fixes this:

diff --git a/security/security.c b/security/security.c
index da80a8918e7d..f6ea028dbc7e 100644
--- a/security/security.c
+++ b/security/security.c
@@ -95,6 +95,14 @@ static __initconst const char *const
builtin_lsm_order =3D CONFIG_LSM;
 static __initdata struct lsm_info **ordered_lsms;
 static __initdata struct lsm_info *exclusive;

+
+#ifdef CONFIG_HAVE_STATIC_CALL
+#define LSM_HOOK_TRAMP(NAME, NUM) \
+       &STATIC_CALL_TRAMP(LSM_STATIC_CALL(NAME, NUM))
+#else
+#define LSM_HOOK_TRAMP(NAME, NUM) NULL
+#endif
+
 /*
  * Define static calls and static keys for each LSM hook.
  */
@@ -123,7 +131,7 @@ struct lsm_static_calls_table static_calls_table
__ro_after_init =3D {
 #define INIT_LSM_STATIC_CALL(NUM, NAME)
         \
        (struct lsm_static_call) {                                      \
                .key =3D &STATIC_CALL_KEY(LSM_STATIC_CALL(NAME, NUM)),    \
-               .trampoline =3D &STATIC_CALL_TRAMP(LSM_STATIC_CALL(NAME, NU=
M)),\
+               .trampoline =3D LSM_HOOK_TRAMP(NAME, NUM),                \
                .active =3D &SECURITY_HOOK_ACTIVE_KEY(NAME, NUM),         \
        },
 #define LSM_HOOK(RET, DEFAULT, NAME, ...)                              \

The trampoline is not used as the static call just ends up being an
indirect call. I will fix this in the next revision.


> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

