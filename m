Return-Path: <bpf+bounces-28299-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7B878B81A4
	for <lists+bpf@lfdr.de>; Tue, 30 Apr 2024 22:42:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7F0C1C2421F
	for <lists+bpf@lfdr.de>; Tue, 30 Apr 2024 20:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A3701A0AFA;
	Tue, 30 Apr 2024 20:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WdCjtm6k"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B361A0AEA
	for <bpf@vger.kernel.org>; Tue, 30 Apr 2024 20:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714509738; cv=none; b=K499TBZIKwYICsi+lOoSQjW2eXF9LXRjaGgYXqpHqvWppBx29zYdqTF5hWNSzmldFB97svfbQvIFzMQWVMfCTeEFzyzKCpWfn3e+ha3KlkjQeMOkjQJzXrVMq/0mmYxcL51Tv+iZcCuTFJfi6NZ2ugaxfH0/Ke6Ff96o18WwoEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714509738; c=relaxed/simple;
	bh=C7Irxux/j6sospZeqmB6rrCIosUYGm57yn0RRhl3PAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uUve76j4V1mFMmq8N95Mcj9UxWWg7MWInoJfLVE2MVJvFfrmILV1HAoncnaHGVUtQ/YWeNzzldyPJ2/Xtcg4EXbZzo1Zy+/qgxRjluu34Hyc+XDlpOXlCnp58CP5doDIbbOsCi8jP8H/+/xde9OMMzfAv+2VfigdJvTDcWK0sbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WdCjtm6k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F705C2BBFC;
	Tue, 30 Apr 2024 20:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714509738;
	bh=C7Irxux/j6sospZeqmB6rrCIosUYGm57yn0RRhl3PAk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WdCjtm6kkji3U2fnZX/g5OXJTL9K2Gla8D809L6Tcty9K6yA9ctzamzvvdevjQ/UB
	 Kov1jrqOn+OgwjnL45Oqz/PlrWp9bmjqzkwUfe2n3LONcYdEwoTvugrcC43Dll2P4r
	 qsY1VRf/qF2oO6GYo2bD8q3yqBBimy5o1nbsLppawIJgB1B182g5G59xbl+5OuVXXN
	 KCtkqKHKRtcIKv0/sWxWPOsDOmYN/m22qYdJm1FPBonTNGGWVb8pDGO7j6UraaJhAp
	 R6SUamis4A4u5AsQyC3KX2Lh/4fijuO5ScRIefcC4RsgO4haTfgDELlBfy3Jpnx3Q3
	 DsaYLMY+1h51w==
Date: Tue, 30 Apr 2024 17:42:14 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: jolsa@kernel.org, quentin@isovalent.com, alan.maguire@oracle.com,
	eddyz87@gmail.com, andrii.nakryiko@gmail.com, ast@kernel.org,
	daniel@iogearbox.net, bpf@vger.kernel.org
Subject: Re: [PATCH dwarves v9 3/3] pahole: Inject kfunc decl tags into BTF
Message-ID: <ZjFXpgRjpDyDnvdc@x1>
References: <cover.1714430735.git.dxu@dxuuu.xyz>
 <26ec519a00aa47f25bc6b4c7e4e15e5191ba4d45.1714430735.git.dxu@dxuuu.xyz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <26ec519a00aa47f25bc6b4c7e4e15e5191ba4d45.1714430735.git.dxu@dxuuu.xyz>

On Mon, Apr 29, 2024 at 04:46:00PM -0600, Daniel Xu wrote:
> This commit teaches pahole to parse symbols in .BTF_ids section in
> vmlinux and discover exported kfuncs. Pahole then takes the list of
> kfuncs and injects a BTF_KIND_DECL_TAG for each kfunc.
> 
> Example of encoding:
> 
>         $ bpftool btf dump file .tmp_vmlinux.btf | rg "DECL_TAG 'bpf_kfunc'" | wc -l
>         121
> 
>         $ bpftool btf dump file .tmp_vmlinux.btf | rg 56337
>         [56337] FUNC 'bpf_ct_change_timeout' type_id=56336 linkage=static
>         [127861] DECL_TAG 'bpf_kfunc' type_id=56337 component_idx=-1
> 
> This enables downstream users and tools to dynamically discover which
> kfuncs are available on a system by parsing vmlinux or module BTF, both
> available in /sys/kernel/btf.
> 
> This feature is enabled with --btf_features=decl_tag,decl_tag_kfuncs.

I'm trying this but:

⬢[acme@toolbox pahole]$ time pahole -j --btf_features=decl_tag,decl_tag_kfuncs --btf_encode_detached=vmlinux.btf.decl_tag,decl_tag_kfuncs vmlinux
btf_encoder__tag_kfuncs(cgroup_rstat_updated): found=0
btf_encoder__tag_kfuncs(cgroup_rstat_flush): found=0
btf_encoder__tag_kfuncs(security_file_permission): found=0
btf_encoder__tag_kfuncs(security_inode_getattr): found=0
btf_encoder__tag_kfuncs(security_file_open): found=0
btf_encoder__tag_kfuncs(security_path_truncate): found=0
btf_encoder__tag_kfuncs(vfs_truncate): found=0
btf_encoder__tag_kfuncs(vfs_fallocate): found=0
btf_encoder__tag_kfuncs(dentry_open): found=0
btf_encoder__tag_kfuncs(vfs_getattr): found=0
btf_encoder__tag_kfuncs(filp_close): found=0
btf_encoder__tag_kfuncs(bpf_lookup_user_key): found=0
btf_encoder__tag_kfuncs(bpf_lookup_system_key): found=0
btf_encoder__tag_kfuncs(bpf_key_put): found=0
btf_encoder__tag_kfuncs(bpf_verify_pkcs7_signature): found=0
btf_encoder__tag_kfuncs(bpf_obj_new_impl): found=0
<SNIP all with found=0>

With:

⬢[acme@toolbox pahole]$ git diff -U16
diff --git a/btf_encoder.c b/btf_encoder.c
index c2df2bc7a374447b..27a16d6564381b60 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -1689,32 +1689,35 @@ static int btf_encoder__tag_kfuncs(struct btf_encoder *encoder)
 		func = get_func_name(name);
 		if (!func)
 			continue;
 
 		/* Check if function belongs to a kfunc set */
 		ranges = gobuffer__entries(&btf_kfunc_ranges);
 		ranges_cnt = gobuffer__nr_entries(&btf_kfunc_ranges);
 		found = false;
 		for (j = 0; j < ranges_cnt; j++) {
 			size_t addr = sym.st_value;
 
 			if (ranges[j].start <= addr && addr < ranges[j].end) {
 				found = true;
 				break;
 			}
 		}
+
+		printf("%s(%s): found=%d\n", __func__, func, found);
+
 		if (!found) {
 			free(func);
 			continue;
 		}
 
 		err = btf_encoder__tag_kfunc(encoder, &btf_funcs, func);
 		if (err) {
 			fprintf(stderr, "%s: failed to tag kfunc '%s'\n", __func__, func);
 			free(func);
 			goto out;
 		}
 		free(func);
 	}
 
 	err = 0;
 out:

--------------

The vmlinux I'm testing on has the kfuncs, etc, as we can see with:

⬢[acme@toolbox pahole]$ readelf -sW vmlinux | grep __BTF_ID__func__ | wc -l
517
⬢[acme@toolbox pahole]$ readelf -sW vmlinux | grep __BTF_ID__func__ | tail
 97887: ffffffff83266bfc     4 OBJECT  LOCAL  DEFAULT   15 __BTF_ID__func__cubictcp_cong_avoid__805493
 97888: ffffffff83266c04     4 OBJECT  LOCAL  DEFAULT   15 __BTF_ID__func__cubictcp_state__806494
 97889: ffffffff83266c0c     4 OBJECT  LOCAL  DEFAULT   15 __BTF_ID__func__cubictcp_cwnd_event__807495
 97890: ffffffff83266c14     4 OBJECT  LOCAL  DEFAULT   15 __BTF_ID__func__cubictcp_acked__808496
 98068: ffffffff83266c24     4 OBJECT  LOCAL  DEFAULT   15 __BTF_ID__func__tcp_reno_ssthresh__773199
 98069: ffffffff83266c2c     4 OBJECT  LOCAL  DEFAULT   15 __BTF_ID__func__tcp_reno_cong_avoid__774200
 98070: ffffffff83266c34     4 OBJECT  LOCAL  DEFAULT   15 __BTF_ID__func__tcp_reno_undo_cwnd__775201
 98071: ffffffff83266c3c     4 OBJECT  LOCAL  DEFAULT   15 __BTF_ID__func__tcp_slow_start__776202
 98072: ffffffff83266c44     4 OBJECT  LOCAL  DEFAULT   15 __BTF_ID__func__tcp_cong_avoid_ai__777203
101522: ffffffff83266c5c     4 OBJECT  LOCAL  DEFAULT   15 __BTF_ID__func__update_socket_protocol__80024
⬢[acme@toolbox pahole]$


So that btf_encoder__tag_kfuncs() isn't finding any?

$ pahole -j --btf_features=decl_tag,decl_tag_kfuncs --btf_encode_detached=vmlinux.btf.decl_tag,decl_tag_kfuncs vmlinux
btf_encoder__tag_kfuncs(vmlinux)

Yeah, getting the source filename, the right one.

Then is_sym_kfunc_set() never returns true... But:

⬢[acme@toolbox pahole]$ time pahole -j --btf_features=decl_tag,decl_tag_kfuncs --btf_encode_detached=vmlinux.btf.decl_tag,decl_tag_kfuncs vmlinux
is_sym_kfunc_set(__BTF_ID__set8__bpf_rstat_kfunc_ids, BTF_ID_SET8_PFX=__BTF_ID__set8__)
is_sym_kfunc_set(__BTF_ID__set8__key_sig_kfunc_set, BTF_ID_SET8_PFX=__BTF_ID__set8__)
is_sym_kfunc_set(__BTF_ID__set8__generic_btf_ids, BTF_ID_SET8_PFX=__BTF_ID__set8__)
is_sym_kfunc_set(__BTF_ID__set8__common_btf_ids, BTF_ID_SET8_PFX=__BTF_ID__set8__)
is_sym_kfunc_set(__BTF_ID__set8__bpf_map_iter_kfunc_ids, BTF_ID_SET8_PFX=__BTF_ID__set8__)
is_sym_kfunc_set(__BTF_ID__set8__cpumask_kfunc_btf_ids, BTF_ID_SET8_PFX=__BTF_ID__set8__)
is_sym_kfunc_set(__BTF_ID__set8__hid_bpf_kfunc_ids, BTF_ID_SET8_PFX=__BTF_ID__set8__)
is_sym_kfunc_set(__BTF_ID__set8__hid_bpf_fmodret_ids, BTF_ID_SET8_PFX=__BTF_ID__set8__)
is_sym_kfunc_set(__BTF_ID__set8__hid_bpf_syscall_kfunc_ids, BTF_ID_SET8_PFX=__BTF_ID__set8__)
is_sym_kfunc_set(__BTF_ID__set8__bpf_kfunc_check_set_skb, BTF_ID_SET8_PFX=__BTF_ID__set8__)
is_sym_kfunc_set(__BTF_ID__set8__bpf_kfunc_check_set_xdp, BTF_ID_SET8_PFX=__BTF_ID__set8__)
is_sym_kfunc_set(__BTF_ID__set8__bpf_kfunc_check_set_sock_addr, BTF_ID_SET8_PFX=__BTF_ID__set8__)
is_sym_kfunc_set(__BTF_ID__set8__bpf_sk_iter_kfunc_ids, BTF_ID_SET8_PFX=__BTF_ID__set8__)
is_sym_kfunc_set(__BTF_ID__set8__xdp_metadata_kfunc_ids, BTF_ID_SET8_PFX=__BTF_ID__set8__)
is_sym_kfunc_set(__BTF_ID__set8__bpf_test_modify_return_ids, BTF_ID_SET8_PFX=__BTF_ID__set8__)
is_sym_kfunc_set(__BTF_ID__set8__test_sk_check_kfunc_ids, BTF_ID_SET8_PFX=__BTF_ID__set8__)
is_sym_kfunc_set(__BTF_ID__set8__tcp_cubic_check_kfunc_ids, BTF_ID_SET8_PFX=__BTF_ID__set8__)
is_sym_kfunc_set(__BTF_ID__set8__bpf_tcp_ca_check_kfunc_ids, BTF_ID_SET8_PFX=__BTF_ID__set8__)
is_sym_kfunc_set(__BTF_ID__set8__bpf_mptcp_fmodret_ids, BTF_ID_SET8_PFX=__BTF_ID__set8__)

real	0m5.586s
user	0m29.707s
sys	0m2.160s
⬢[acme@toolbox pahole]$

And then:

⬢[acme@toolbox pahole]$ time pahole -j --btf_features=decl_tag,decl_tag_kfuncs --btf_encode_detached=vmlinux.btf.decl_tag,decl_tag_kfuncs vmlinux
is_sym_kfunc_set(__BTF_ID__set8__bpf_rstat_kfunc_ids, BTF_ID_SET8_PFX=__BTF_ID__set8__, set->flags= 0, BTF_SET8_KFUNCS=1, ret=0)
is_sym_kfunc_set(__BTF_ID__set8__key_sig_kfunc_set, BTF_ID_SET8_PFX=__BTF_ID__set8__, set->flags= 0, BTF_SET8_KFUNCS=1, ret=0)
is_sym_kfunc_set(__BTF_ID__set8__generic_btf_ids, BTF_ID_SET8_PFX=__BTF_ID__set8__, set->flags= 0, BTF_SET8_KFUNCS=1, ret=0)
is_sym_kfunc_set(__BTF_ID__set8__common_btf_ids, BTF_ID_SET8_PFX=__BTF_ID__set8__, set->flags= 0, BTF_SET8_KFUNCS=1, ret=0)
is_sym_kfunc_set(__BTF_ID__set8__bpf_map_iter_kfunc_ids, BTF_ID_SET8_PFX=__BTF_ID__set8__, set->flags= 0, BTF_SET8_KFUNCS=1, ret=0)
is_sym_kfunc_set(__BTF_ID__set8__cpumask_kfunc_btf_ids, BTF_ID_SET8_PFX=__BTF_ID__set8__, set->flags= 0, BTF_SET8_KFUNCS=1, ret=0)
is_sym_kfunc_set(__BTF_ID__set8__hid_bpf_kfunc_ids, BTF_ID_SET8_PFX=__BTF_ID__set8__, set->flags= 0, BTF_SET8_KFUNCS=1, ret=0)
is_sym_kfunc_set(__BTF_ID__set8__hid_bpf_fmodret_ids, BTF_ID_SET8_PFX=__BTF_ID__set8__, set->flags= 0, BTF_SET8_KFUNCS=1, ret=0)
is_sym_kfunc_set(__BTF_ID__set8__hid_bpf_syscall_kfunc_ids, BTF_ID_SET8_PFX=__BTF_ID__set8__, set->flags= 0, BTF_SET8_KFUNCS=1, ret=0)
is_sym_kfunc_set(__BTF_ID__set8__bpf_kfunc_check_set_skb, BTF_ID_SET8_PFX=__BTF_ID__set8__, set->flags= 0, BTF_SET8_KFUNCS=1, ret=0)
is_sym_kfunc_set(__BTF_ID__set8__bpf_kfunc_check_set_xdp, BTF_ID_SET8_PFX=__BTF_ID__set8__, set->flags= 0, BTF_SET8_KFUNCS=1, ret=0)
is_sym_kfunc_set(__BTF_ID__set8__bpf_kfunc_check_set_sock_addr, BTF_ID_SET8_PFX=__BTF_ID__set8__, set->flags= 0, BTF_SET8_KFUNCS=1, ret=0)
is_sym_kfunc_set(__BTF_ID__set8__bpf_sk_iter_kfunc_ids, BTF_ID_SET8_PFX=__BTF_ID__set8__, set->flags= 0, BTF_SET8_KFUNCS=1, ret=0)
is_sym_kfunc_set(__BTF_ID__set8__xdp_metadata_kfunc_ids, BTF_ID_SET8_PFX=__BTF_ID__set8__, set->flags= 0, BTF_SET8_KFUNCS=1, ret=0)
is_sym_kfunc_set(__BTF_ID__set8__bpf_test_modify_return_ids, BTF_ID_SET8_PFX=__BTF_ID__set8__, set->flags= 0, BTF_SET8_KFUNCS=1, ret=0)
is_sym_kfunc_set(__BTF_ID__set8__test_sk_check_kfunc_ids, BTF_ID_SET8_PFX=__BTF_ID__set8__, set->flags= 0, BTF_SET8_KFUNCS=1, ret=0)
is_sym_kfunc_set(__BTF_ID__set8__tcp_cubic_check_kfunc_ids, BTF_ID_SET8_PFX=__BTF_ID__set8__, set->flags= 0, BTF_SET8_KFUNCS=1, ret=0)
is_sym_kfunc_set(__BTF_ID__set8__bpf_tcp_ca_check_kfunc_ids, BTF_ID_SET8_PFX=__BTF_ID__set8__, set->flags= 0, BTF_SET8_KFUNCS=1, ret=0)
is_sym_kfunc_set(__BTF_ID__set8__bpf_mptcp_fmodret_ids, BTF_ID_SET8_PFX=__BTF_ID__set8__, set->flags= 0, BTF_SET8_KFUNCS=1, ret=0)

real	0m5.597s
user	0m29.620s
sys	0m2.138s
⬢[acme@toolbox pahole]$

Run out of time, I probably am using an old vmlinux, will try later with
one generated from a current kernel, or maybe you guys point to my
st00pidity saying what I am missing 8-)

- Arnaldo

