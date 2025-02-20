Return-Path: <bpf+bounces-52097-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FE58A3E424
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 19:44:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 318DB16BF4A
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 18:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E758C24BD04;
	Thu, 20 Feb 2025 18:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FOkZz7E0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BA62147F9;
	Thu, 20 Feb 2025 18:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740077028; cv=none; b=eS5ncfq9BgZC1C7JDK655o5z1lOWYoVtm4Ct/B7+4KmDFCVB9xhjtCBK4BgLm/PixMcXVZ10hOp/XPsafFSqUb1+/hJqeX31pEhS4DrIb5YHrlXI0Jw585CspoHNccUykeFRiyLnHL/thq4syqZ/rLtLhh6WXDJJyX88ve2pFiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740077028; c=relaxed/simple;
	bh=Nfu/4Zkn8wfTErj7BP3jILyeRCqN6MA6v6R7/W7+n+E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=k/DD9oo7K+GjxZR5BVmqdwaS1YjwMcw/sJ7gxcKPI02lrir3rTw+11DOF9peOP0J1kLAahDNCsWOjjXqJVeWvlYTCVZ38nEZylls2j0NU82oFZctcziGAasM3lZGQlI6XJmJXfmKzUDwEP/c4G4eoAeDLSBnOtqDt7HtcieIraM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FOkZz7E0; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-21c2f1b610dso35362875ad.0;
        Thu, 20 Feb 2025 10:43:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740077026; x=1740681826; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=K0ASxNxYyYZ9gcabpBRrcFcWraXO/xOVrjlSpdgY9Is=;
        b=FOkZz7E0cn52ZrYb2uQrnbe4Y5lhRBqpwGOoC5Z2Aeu05JZuyGr/1g5n2ACW7J74qO
         S8pH52AJEFOdxyu+hdnOhAudyO+YqnUpLYESiqwixIV847jM4jEQ1bp9U2reJRXok+G7
         R0vqojn64Y0SXYRFNF6MGD1zWRyKb/WUgOz4xg1xEzeVdquDRGkbG7KcYBcxzLBrsWQo
         9pE+NRwfzaTu8uD2glJyMhD4gzlVRs+iC2/7GrR/iHdJaPZ9YkHeG154o8T9yyYyMNxI
         PeaEhR0HRLpFwEE9HV3WaKY1i9P851ELDScHwWoD7eKohqVywBBskA0+ogpfWwnWq7yw
         OyKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740077026; x=1740681826;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K0ASxNxYyYZ9gcabpBRrcFcWraXO/xOVrjlSpdgY9Is=;
        b=PwJNQR1WGpSIxPOMHfngRFQBWy86YbwlJ8pYDsnyKerR2ITaYfNjsuORAPfssXmyAD
         KvnaFQXddrST/t+AS71Kid2H97hUX2bYRciCcsq/Htwm+NxXei6PGtdarZApKnIesVV4
         Y8tR75Yyv1DlaSW7P0vWBp4PMv6+oeA19uNiA311tjmI3UWQqaD3e3J8L1KyXKwql0s/
         1k7la0yaR2Iz5c0zhS4gc75FHPzfeNFZ4FMVVyHcF+hCJH9ZB9sHWi/KpUc5Ap6yCZ5I
         yni/CbNep2+DaZDJb+r7+cENkOFUadDx37kp4GaRFfp71Ao9JD5CpYen/2O1rEHQAqpF
         GWkg==
X-Forwarded-Encrypted: i=1; AJvYcCXWQv1Lvkd/VgokMdFhjPajoUgDb8sh+jtRZM4d8fynVrcK4oRPsTuApCGKQUVmChnYk854AlqrkevF+rg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyONa1c1bDYKMOYJvKN8XEJF2Mf26w69v9vwWDqR/Lb2jFu1ngg
	mheh/skhFTsxvY0u3kx/mAJIi8ywZ8a1Bc9vor43m1fNNK8utLO57wrBBTbo
X-Gm-Gg: ASbGnctJHnF85yp8WBrXHbbB7SNKe6OmMfm/79XeJdIfQqjrP1dL+pxQ+IuT3CCb0zb
	Kb1kDb+P5yTRo5avj+6p+5oXN2Cn1RKueu+/1lk76/ooqYg1vPB+kNGCYSQXPBpZrvJsn920GHg
	h89d7Kl+YmV4IPXpc3Fb4GMFijNmP2dv92IoWrnJixYTxXYiTPK4R4N5JPa0JnVcSExF6JTWn+G
	4MT9JPsIHikHHip2yYVmPJ2hautuihmPszv0EZn/+l7QTJvtxJ0WlLdCyPcwHs4+4JnBwMWNZfD
	nQnu0IxV37fe
X-Google-Smtp-Source: AGHT+IGPKKcQ1l/8JsVwLEOeA3IeprQWj+JLrsU3fl4K1jgeM8iVZR29dWQAR/+6ouG0i+6OeA5YWg==
X-Received: by 2002:a05:6a20:3d84:b0:1ee:b033:6dde with SMTP id adf61e73a8af0-1eef3c720d5mr411019637.3.1740077026094;
        Thu, 20 Feb 2025 10:43:46 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7326a38ff76sm9935769b3a.160.2025.02.20.10.43.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 10:43:45 -0800 (PST)
Message-ID: <475831c7d175529df4cc638506217c67010bf8da.camel@gmail.com>
Subject: Re: [PATCH RESEND bpf-next v7 0/4] Add prog_kfunc feature probe
From: Eduard Zingerman <eddyz87@gmail.com>
To: Tao Chen <chen.dylane@gmail.com>, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, haoluo@google.com, jolsa@kernel.org, qmo@kernel.org
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 20 Feb 2025 10:43:41 -0800
In-Reply-To: <0eee016f-2d37-4c80-98cf-fc134d3ad917@gmail.com>
References: <20250212153912.24116-1-chen.dylane@gmail.com>
	 <2b025df3-144b-4909-a2b4-66356540f71c@gmail.com>
	 <598a7d089936b18472937679d4131286f102cb18.camel@gmail.com>
	 <0eee016f-2d37-4c80-98cf-fc134d3ad917@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-02-21 at 02:09 +0800, Tao Chen wrote:

[...]

> Hi Eduard,
>=20
> I try to run your test case, but it seems btf_is_decl_tag always return=
=20
> false, Are there any special restrictions for the tag feature of btf=EF=
=BC=9F

Hi Tao,
=20
> My compilation environment=EF=BC=9A
>=20
> pahole --version
> v1.29
> clang --version
> Ubuntu clang version 18.1.3 (1ubuntu1)

Hm, pahole should generate kfunc tags since 1.27.
I use pahole 'next' branch, but it is the same as 1.29 at the moment.
Do you see kfunc prototypes at the bottom of vmlinux.h?
They look like so:

  ...
  extern u32 tcp_reno_undo_cwnd(struct sock *sk) __weak __ksym;
  ...

These are generated by bpftool from decl tags I look for in the test case.
Decl tags are inserted by pahole, see btf_encoder.c:btf_encoder__tag_kfuncs=
().

Anyways, below is the list of all kfuncs from my config,
it is possible to adapt the test case with something like this:

        for (i =3D 0; i < ARRAY_SIZE(all_kfuncs); ++i) {
                kfunc =3D all_kfuncs[i];
                kfunc_id =3D btf__find_by_name_kind(vmlinux_btf, kfunc, BTF=
_KIND_FUNC);
                printf("%-42s ", kfunc);
                if (kfunc_id < 0) {
                        printf("<not found>\n");
                        continue;
                }
                ...
        }

--- 8< --------------------------------------

static const char *all_kfuncs[] =3D {
	"bbr_cwnd_event",
	"bbr_init",
	"bbr_main",
	"bbr_min_tso_segs",
	"bbr_set_state",
	"bbr_sndbuf_expand",
	"bbr_ssthresh",
	"bbr_undo_cwnd",
	"bpf_arena_alloc_pages",
	"bpf_arena_free_pages",
	"bpf_cast_to_kern_ctx",
	"bpf_cgroup_acquire",
	"bpf_cgroup_ancestor",
	"bpf_cgroup_from_id",
	"bpf_cgroup_release",
	"bpf_copy_from_user_str",
	"bpf_cpumask_acquire",
	"bpf_cpumask_and",
	"bpf_cpumask_any_and_distribute",
	"bpf_cpumask_any_distribute",
	"bpf_cpumask_clear",
	"bpf_cpumask_clear_cpu",
	"bpf_cpumask_copy",
	"bpf_cpumask_create",
	"bpf_cpumask_empty",
	"bpf_cpumask_equal",
	"bpf_cpumask_first",
	"bpf_cpumask_first_and",
	"bpf_cpumask_first_zero",
	"bpf_cpumask_full",
	"bpf_cpumask_intersects",
	"bpf_cpumask_or",
	"bpf_cpumask_release",
	"bpf_cpumask_set_cpu",
	"bpf_cpumask_setall",
	"bpf_cpumask_subset",
	"bpf_cpumask_test_and_clear_cpu",
	"bpf_cpumask_test_and_set_cpu",
	"bpf_cpumask_test_cpu",
	"bpf_cpumask_weight",
	"bpf_cpumask_xor",
	"bpf_crypto_ctx_acquire",
	"bpf_crypto_ctx_create",
	"bpf_crypto_ctx_release",
	"bpf_crypto_decrypt",
	"bpf_crypto_encrypt",
	"bpf_ct_change_status",
	"bpf_ct_change_timeout",
	"bpf_ct_insert_entry",
	"bpf_ct_release",
	"bpf_ct_set_nat_info",
	"bpf_ct_set_status",
	"bpf_ct_set_timeout",
	"bpf_dynptr_adjust",
	"bpf_dynptr_clone",
	"bpf_dynptr_from_skb",
	"bpf_dynptr_from_xdp",
	"bpf_dynptr_is_null",
	"bpf_dynptr_is_rdonly",
	"bpf_dynptr_size",
	"bpf_dynptr_slice",
	"bpf_dynptr_slice_rdwr",
	"bpf_fentry_test1",
	"bpf_get_dentry_xattr",
	"bpf_get_file_xattr",
	"bpf_get_fsverity_digest",
	"bpf_get_kmem_cache",
	"bpf_get_task_exe_file",
	"bpf_iter_bits_destroy",
	"bpf_iter_bits_new",
	"bpf_iter_bits_next",
	"bpf_iter_css_destroy",
	"bpf_iter_css_new",
	"bpf_iter_css_next",
	"bpf_iter_css_task_destroy",
	"bpf_iter_css_task_new",
	"bpf_iter_css_task_next",
	"bpf_iter_kmem_cache_destroy",
	"bpf_iter_kmem_cache_new",
	"bpf_iter_kmem_cache_next",
	"bpf_iter_num_destroy",
	"bpf_iter_num_new",
	"bpf_iter_num_next",
	"bpf_iter_scx_dsq_destroy",
	"bpf_iter_scx_dsq_new",
	"bpf_iter_scx_dsq_next",
	"bpf_iter_task_destroy",
	"bpf_iter_task_new",
	"bpf_iter_task_next",
	"bpf_iter_task_vma_destroy",
	"bpf_iter_task_vma_new",
	"bpf_iter_task_vma_next",
	"bpf_key_put",
	"bpf_kfunc_call_memb_release",
	"bpf_kfunc_call_test_release",
	"bpf_list_pop_back",
	"bpf_list_pop_front",
	"bpf_list_push_back_impl",
	"bpf_list_push_front_impl",
	"bpf_local_irq_restore",
	"bpf_local_irq_save",
	"bpf_lookup_system_key",
	"bpf_lookup_user_key",
	"bpf_map_sum_elem_count",
	"bpf_modify_return_test",
	"bpf_modify_return_test2",
	"bpf_modify_return_test_tp",
	"bpf_obj_drop_impl",
	"bpf_obj_new_impl",
	"bpf_path_d_path",
	"bpf_percpu_obj_drop_impl",
	"bpf_percpu_obj_new_impl",
	"bpf_preempt_disable",
	"bpf_preempt_enable",
	"bpf_put_file",
	"bpf_rbtree_add_impl",
	"bpf_rbtree_first",
	"bpf_rbtree_remove",
	"bpf_rcu_read_lock",
	"bpf_rcu_read_unlock",
	"bpf_rdonly_cast",
	"bpf_refcount_acquire_impl",
	"bpf_remove_dentry_xattr",
	"bpf_send_signal_task",
	"bpf_session_cookie",
	"bpf_session_is_return",
	"bpf_set_dentry_xattr",
	"bpf_sk_assign_tcp_reqsk",
	"bpf_skb_ct_alloc",
	"bpf_skb_ct_lookup",
	"bpf_skb_get_fou_encap",
	"bpf_skb_get_xfrm_info",
	"bpf_skb_set_fou_encap",
	"bpf_skb_set_xfrm_info",
	"bpf_sock_addr_set_sun_path",
	"bpf_sock_destroy",
	"bpf_task_acquire",
	"bpf_task_from_pid",
	"bpf_task_from_vpid",
	"bpf_task_get_cgroup1",
	"bpf_task_release",
	"bpf_task_under_cgroup",
	"bpf_throw",
	"bpf_verify_pkcs7_signature",
	"bpf_wq_init",
	"bpf_wq_set_callback_impl",
	"bpf_wq_start",
	"bpf_xdp_ct_alloc",
	"bpf_xdp_ct_lookup",
	"bpf_xdp_flow_lookup",
	"bpf_xdp_get_xfrm_state",
	"bpf_xdp_metadata_rx_hash",
	"bpf_xdp_metadata_rx_timestamp",
	"bpf_xdp_metadata_rx_vlan_tag",
	"bpf_xdp_xfrm_state_release",
	"cgroup_rstat_flush",
	"cgroup_rstat_updated",
	"crash_kexec",
	"cubictcp_acked",
	"cubictcp_cong_avoid",
	"cubictcp_cwnd_event",
	"cubictcp_init",
	"cubictcp_recalc_ssthresh",
	"cubictcp_state",
	"dctcp_cwnd_event",
	"dctcp_cwnd_undo",
	"dctcp_init",
	"dctcp_ssthresh",
	"dctcp_state",
	"dctcp_update_alpha",
	"scx_bpf_consume",
	"scx_bpf_cpu_rq",
	"scx_bpf_cpuperf_cap",
	"scx_bpf_cpuperf_cur",
	"scx_bpf_cpuperf_set",
	"scx_bpf_create_dsq",
	"scx_bpf_destroy_dsq",
	"scx_bpf_dispatch",
	"scx_bpf_dispatch_cancel",
	"scx_bpf_dispatch_from_dsq",
	"scx_bpf_dispatch_from_dsq_set_slice",
	"scx_bpf_dispatch_from_dsq_set_vtime",
	"scx_bpf_dispatch_nr_slots",
	"scx_bpf_dispatch_vtime",
	"scx_bpf_dispatch_vtime_from_dsq",
	"scx_bpf_dsq_insert",
	"scx_bpf_dsq_insert_vtime",
	"scx_bpf_dsq_move",
	"scx_bpf_dsq_move_set_slice",
	"scx_bpf_dsq_move_set_vtime",
	"scx_bpf_dsq_move_to_local",
	"scx_bpf_dsq_move_vtime",
	"scx_bpf_dsq_nr_queued",
	"scx_bpf_dump_bstr",
	"scx_bpf_error_bstr",
	"scx_bpf_exit_bstr",
	"scx_bpf_get_idle_cpumask",
	"scx_bpf_get_idle_smtmask",
	"scx_bpf_get_online_cpumask",
	"scx_bpf_get_possible_cpumask",
	"scx_bpf_kick_cpu",
	"scx_bpf_now",
	"scx_bpf_nr_cpu_ids",
	"scx_bpf_pick_any_cpu",
	"scx_bpf_pick_idle_cpu",
	"scx_bpf_put_cpumask",
	"scx_bpf_put_idle_cpumask",
	"scx_bpf_reenqueue_local",
	"scx_bpf_select_cpu_dfl",
	"scx_bpf_task_cgroup",
	"scx_bpf_task_cpu",
	"scx_bpf_task_running",
	"scx_bpf_test_and_clear_cpu_idle",
	"tcp_cong_avoid_ai",
	"tcp_reno_cong_avoid",
	"tcp_reno_ssthresh",
	"tcp_reno_undo_cwnd",
	"tcp_slow_start",
};

-------------------------------------- >8 ---

[...]


