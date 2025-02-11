Return-Path: <bpf+bounces-51102-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17346A3027B
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 05:12:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF0163A836B
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 04:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A071D63D1;
	Tue, 11 Feb 2025 04:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fn1U7ots"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F8F130E58
	for <bpf@vger.kernel.org>; Tue, 11 Feb 2025 04:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739247160; cv=none; b=LplysQMM9iRiGsYNIY6C7UtoBvwNCjM9rb2rh2GW1Fve/ZWpiv0+KRN2Wi0b9/floPJ29R5kvBldcYnvD4DGKVm6b2aPhb9jyiYn/O3cVSrmmCx44XoTEYEYOKi+SJWXUT2PdEfygIVW9C6HQ0t2/0KzsXh02ZmNTSY3+z5fbm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739247160; c=relaxed/simple;
	bh=7GltykBkHx/+DBPHZUOHggMJ7u712sdmsVQRzxyWW3Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PQ2MzqxZH4IbLTCkNZPbBsVm9MOC6S4Ke0hbVXa9eCIQVjCOjcyww4N0vGGtaxSyuUZFhvb4E7NQSmpaby/h3T2a/gT+fASaRL0L1f5h7j4KP/r8/hpjtLBWSc2VcWk19lJHsZHAKrxEQV8eCQcLpufAct0zpB/4q4MsE76LqVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fn1U7ots; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2f9f6a2fa8dso7028578a91.1
        for <bpf@vger.kernel.org>; Mon, 10 Feb 2025 20:12:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739247158; x=1739851958; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+xDQP7+REyONni+CEQ78+Lyxd0AL3IwOIlhtyHyrN7g=;
        b=fn1U7otsiylIyg9WphzKi9sgSeS0t8fd4LcJ+vvOYS9xLGeR/qK/MX16YgjchTf2wu
         mucy7PZN07q7FGdGlftU/q26xvIBCjHsiRs1YPvk0gbdp05zHG9q8WIBIlacRzd1uydk
         GQ/wQ8Hegi0EwxEF1WxbTVPFroK3jqlmJb1cdapHrkcQdC4qd34WW1Bf21gegKpTenhc
         7SMdHnXhR+SLp/Uj4dvcK5iXIielQqcFGmiAenOayHrmrkWmHvDJTfywnIcF+vaexbEr
         utFRMPSFshnCo3RzjPrrBzXLC01pH1fRpKoQIEPLyujjv3pYJpoKrO7oab/quHFmjtGV
         Aj5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739247158; x=1739851958;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+xDQP7+REyONni+CEQ78+Lyxd0AL3IwOIlhtyHyrN7g=;
        b=nv24Z8rgJ5+iFGyYjoL520v8oQ00m0ArkLWZv4YwF/xM0pGOi8dLPM23C+m3JdBNt0
         OAQkD8FL517HBabbytxtRB+NvZjhj0QQ63fnJLaPmr5Jk7Dfknp3V/eGcEYKjfOMcfYt
         OOIiutvctZWO0qA9ky15TjanS+FMwbV0+2UEVsw0+iD88IZCQkZY5E4S6tOiRsVXvESC
         ZehpMAg+Vt7tdLmirFjeO/aU5L3xyssp4tzEdKozsXYPFFJQU+ac8OE4jx9dZamgjcXW
         ebHI2mKkKF9Oaeh4Y8rXLlmY6a+vmEndeAQ52oF97VEd9hL8leFX2BRtADYcGliAvDkX
         KZ4w==
X-Gm-Message-State: AOJu0Yyqthrc/SMt4inqZfAadivVxrQWThYb0+cUl1d6I8OhWvzndrZn
	nUaDm3+uCBqRy0/1WwGqDNTdByVDZ5QjCsIrzGOaCkbXN3oX/Rbr
X-Gm-Gg: ASbGncvve5BNuCNHXd551eIh1FDgv4agtcRhWUlv/wFcm1PRZiBgabuOmzGp14CK3oI
	NxqAZYZGAotSgRh96w0ilPjOqCHk444OzgDFQ7C8dOVSZ2orbuJSGg5JYUa6goiapMecIeSQX6d
	C0wQrF0xxtq7QD/mzivS4tTJK6f95enmOGEmmjzZxcTOYrk9+oO6UdUdkXkitjFR13LYeQ2C108
	gia7N68qXi1/xBuRC6ovpCTqWrnFNMiovsBAUjBn0slJRm0FHqfIif1gl/1OXUGP91VpU+KceTL
	vN9l+77Z+Css
X-Google-Smtp-Source: AGHT+IE2RLojhqnBJL5BIsq3qVGMpcn8a6W46H3zPfsp/VKw8p1I7PP/XZnnrN9NG0eM0pey3kSV6w==
X-Received: by 2002:a17:90b:3f4d:b0:2ee:c9d8:d01a with SMTP id 98e67ed59e1d1-2fa24064713mr24580772a91.11.1739247158265;
        Mon, 10 Feb 2025 20:12:38 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fa2d831a1csm7359926a91.44.2025.02.10.20.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 20:12:37 -0800 (PST)
Message-ID: <50d8dd8af3822f63f1a13230e6fa77998f0b713d.camel@gmail.com>
Subject: Re: [PATCH bpf-next 1/3] objtool: Move noreturns.h to a common
 location
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yafang Shao <laoar.shao@gmail.com>, ast@kernel.org,
 daniel@iogearbox.net, 	andrii@kernel.org, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, 	john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, 	jolsa@kernel.org,
 jpoimboe@kernel.org, peterz@infradead.org
Cc: bpf@vger.kernel.org
Date: Mon, 10 Feb 2025 20:12:32 -0800
In-Reply-To: <20250211023359.1570-2-laoar.shao@gmail.com>
References: <20250211023359.1570-1-laoar.shao@gmail.com>
	 <20250211023359.1570-2-laoar.shao@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-02-11 at 10:33 +0800, Yafang Shao wrote:

[...]

> diff --git a/tools/include/linux/noreturns.h b/tools/include/linux/noretu=
rns.h
> new file mode 100644
> index 000000000000..b2174894f9f7
> --- /dev/null
> +++ b/tools/include/linux/noreturns.h
> @@ -0,0 +1,52 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +/*
> + * This is a (sorted!) list of all known __noreturn functions in the ker=
nel.
> + * It's needed for objtool to properly reverse-engineer the control flow=
 graph.
> + *
> + * Yes, this is unfortunate.  A better solution is in the works.
> + */

I'm probably out of context for this discussion, sorry if I'm raising
points already discussed.

The DW_AT_noreturn attribute is defined for DWARF. A simple script
like [1] could be used to find all functions with this attribute known
to DWARF. Using this script I see several functions present in my
kernel but not present in the NORETURN list from this patch:
- abort
- devtmpfs_work_loop
- play_dead
- rcu_gp_kthread
- rcu_tasks_kthread

All these are marked as FUNC symbols when doing 'readelf --symbols vmlinux'=
.

'pahole' could be modified to look for DW_AT_noreturn attributes and
add this information in BTF. E.g. by adding special btf_decl_tag to
corresponding FUNC definitions. This won't work if kernel is compiled
w/o BTF, of-course.

[1] https://gist.github.com/eddyz87/d8513a731dfe7e2be52b346aef1de353

> +NORETURN(__fortify_panic)
> +NORETURN(__ia32_sys_exit)
> +NORETURN(__ia32_sys_exit_group)
> +NORETURN(__kunit_abort)
> +NORETURN(__module_put_and_kthread_exit)
> +NORETURN(__stack_chk_fail)
> +NORETURN(__tdx_hypercall_failed)
> +NORETURN(__ubsan_handle_builtin_unreachable)
> +NORETURN(__x64_sys_exit)
> +NORETURN(__x64_sys_exit_group)
> +NORETURN(arch_cpu_idle_dead)
> +NORETURN(bch2_trans_in_restart_error)
> +NORETURN(bch2_trans_restart_error)
> +NORETURN(bch2_trans_unlocked_error)
> +NORETURN(cpu_bringup_and_idle)
> +NORETURN(cpu_startup_entry)
> +NORETURN(do_exit)
> +NORETURN(do_group_exit)
> +NORETURN(do_task_dead)
> +NORETURN(ex_handler_msr_mce)
> +NORETURN(hlt_play_dead)
> +NORETURN(hv_ghcb_terminate)
> +NORETURN(kthread_complete_and_exit)
> +NORETURN(kthread_exit)
> +NORETURN(kunit_try_catch_throw)
> +NORETURN(machine_real_restart)
> +NORETURN(make_task_dead)
> +NORETURN(mpt_halt_firmware)
> +NORETURN(nmi_panic_self_stop)
> +NORETURN(panic)
> +NORETURN(panic_smp_self_stop)
> +NORETURN(rest_init)
> +NORETURN(rewind_stack_and_make_dead)
> +NORETURN(rust_begin_unwind)
> +NORETURN(rust_helper_BUG)
> +NORETURN(sev_es_terminate)
> +NORETURN(snp_abort)
> +NORETURN(start_kernel)
> +NORETURN(stop_this_cpu)
> +NORETURN(usercopy_abort)
> +NORETURN(x86_64_start_kernel)
> +NORETURN(x86_64_start_reservations)
> +NORETURN(xen_cpu_bringup_again)
> +NORETURN(xen_start_kernel)

[...]



