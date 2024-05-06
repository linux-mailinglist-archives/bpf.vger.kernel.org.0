Return-Path: <bpf+bounces-28717-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5D4D8BD607
	for <lists+bpf@lfdr.de>; Mon,  6 May 2024 22:08:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59AB4283D5F
	for <lists+bpf@lfdr.de>; Mon,  6 May 2024 20:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BDE515B0EC;
	Mon,  6 May 2024 20:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tMpri0SN"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88FA1745D9
	for <bpf@vger.kernel.org>; Mon,  6 May 2024 20:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715026081; cv=none; b=GAmQ5RjPAlZoc/6LiQSTKM6sD/QQZs2goRpVdVSyQ/V+ut/p1NPjyi+WcuH6BPi38H5p0JDujNdgT59TgvpipJnfzWzfV4FcFTs93v7Gk2lnedfs2lJCqoOnWZT/b3gSlDIHT8Qy7QHAotiEBbgePYfNBXjX9ZnJlaeOfFY1Y7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715026081; c=relaxed/simple;
	bh=IdnAHyLnxgPjUwAhR3LlJ6TVTylzAFPh2bo4mquvkRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=njG2Cqpn4JUpsZcyPjiNvVvNrUq0CpRqmTYu6t2ba1gJVstOP2tFwrtVCQh/JuGj7XtoZ7aieyx0H2Bya52LlF1kZoKmI9jWeg8clccFF7oh9c4mlmh5dwtD7QNmhITIqQNETG7i8tUr2MvNzHKkII1Wf4GlqcMyLeJ0fGGv4m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tMpri0SN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DF9AC116B1;
	Mon,  6 May 2024 20:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715026081;
	bh=IdnAHyLnxgPjUwAhR3LlJ6TVTylzAFPh2bo4mquvkRE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tMpri0SNZgpOuq7d+fg+mH6Mv6EOf4VHtpqjn38FgmJwnSqh0wZV6oFBqHmnKJrvV
	 N/gPnceiV2YQJDQYlBeqnj53Zrw9EQrU0IPGaKH/jKyYKumge+RRF9yO0uGb4I/sFy
	 8uboWdV83qWlaJk8owFAki1zSuqNvUpQxN+pyS8xDVMkWxnfN8sjJZKFFZhavg8qNd
	 C7Hr/gGBkJXWwGKJK/ELdbCwCgcbhu9ahsoewbYk7iTBeECHhvcsZdLgWhQfJ47OWf
	 ab/t4X4GFqJABxozePyFKAmggf3I+XWVxbGJQ/Z7AhiX8RW+X5+CXYyRPerFExpfKn
	 jitTYwJJ8aHbw==
Date: Mon, 6 May 2024 17:07:54 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: jolsa@kernel.org, quentin@isovalent.com, alan.maguire@oracle.com,
	eddyz87@gmail.com, andrii.nakryiko@gmail.com, ast@kernel.org,
	daniel@iogearbox.net, bpf@vger.kernel.org
Subject: Re: [PATCH dwarves v9 3/3] pahole: Inject kfunc decl tags into BTF
Message-ID: <Zjk4mlHKmukeUc4y@x1>
References: <cover.1714430735.git.dxu@dxuuu.xyz>
 <26ec519a00aa47f25bc6b4c7e4e15e5191ba4d45.1714430735.git.dxu@dxuuu.xyz>
 <ZjFXpgRjpDyDnvdc@x1>
 <zdag4h7ztmwn56yrmieisbhno4gpb24k7rgjevp6gc46e5dxak@3stxrh2qfnlu>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <zdag4h7ztmwn56yrmieisbhno4gpb24k7rgjevp6gc46e5dxak@3stxrh2qfnlu>

On Tue, Apr 30, 2024 at 05:27:24PM -0600, Daniel Xu wrote:
> On Tue, Apr 30, 2024 at 05:42:14PM GMT, Arnaldo Carvalho de Melo wrote:
> > On Mon, Apr 29, 2024 at 04:46:00PM -0600, Daniel Xu wrote:
> > > This commit teaches pahole to parse symbols in .BTF_ids section in
> > > vmlinux and discover exported kfuncs. Pahole then takes the list of
> > > kfuncs and injects a BTF_KIND_DECL_TAG for each kfunc.
> > > 
> > > Example of encoding:
> > > 
> > >         $ bpftool btf dump file .tmp_vmlinux.btf | rg "DECL_TAG 'bpf_kfunc'" | wc -l
> > >         121
> > > 
> > >         $ bpftool btf dump file .tmp_vmlinux.btf | rg 56337
> > >         [56337] FUNC 'bpf_ct_change_timeout' type_id=56336 linkage=static
> > >         [127861] DECL_TAG 'bpf_kfunc' type_id=56337 component_idx=-1
> > > 
> > > This enables downstream users and tools to dynamically discover which
> > > kfuncs are available on a system by parsing vmlinux or module BTF, both
> > > available in /sys/kernel/btf.
> > > 
> > > This feature is enabled with --btf_features=decl_tag,decl_tag_kfuncs.
> > 
> > I'm trying this but:
> > 
> > ⬢[acme@toolbox pahole]$ time pahole -j --btf_features=decl_tag,decl_tag_kfuncs --btf_encode_detached=vmlinux.btf.decl_tag,decl_tag_kfuncs vmlinux
> > btf_encoder__tag_kfuncs(cgroup_rstat_updated): found=0
> > btf_encoder__tag_kfuncs(cgroup_rstat_flush): found=0
> > btf_encoder__tag_kfuncs(security_file_permission): found=0
> > btf_encoder__tag_kfuncs(security_inode_getattr): found=0
> > btf_encoder__tag_kfuncs(security_file_open): found=0
> > btf_encoder__tag_kfuncs(security_path_truncate): found=0
> > btf_encoder__tag_kfuncs(vfs_truncate): found=0
> > btf_encoder__tag_kfuncs(vfs_fallocate): found=0
> > btf_encoder__tag_kfuncs(dentry_open): found=0
> > btf_encoder__tag_kfuncs(vfs_getattr): found=0
> > btf_encoder__tag_kfuncs(filp_close): found=0
> > btf_encoder__tag_kfuncs(bpf_lookup_user_key): found=0
> > btf_encoder__tag_kfuncs(bpf_lookup_system_key): found=0
> > btf_encoder__tag_kfuncs(bpf_key_put): found=0
> > btf_encoder__tag_kfuncs(bpf_verify_pkcs7_signature): found=0
> > btf_encoder__tag_kfuncs(bpf_obj_new_impl): found=0
> > <SNIP all with found=0>
> > 
> > With:
> > 
> > ⬢[acme@toolbox pahole]$ git diff -U16
> > diff --git a/btf_encoder.c b/btf_encoder.c
> > index c2df2bc7a374447b..27a16d6564381b60 100644
> > --- a/btf_encoder.c
> > +++ b/btf_encoder.c
> > @@ -1689,32 +1689,35 @@ static int btf_encoder__tag_kfuncs(struct btf_encoder *encoder)
> >  		func = get_func_name(name);
> >  		if (!func)
> >  			continue;
> >  
> >  		/* Check if function belongs to a kfunc set */
> >  		ranges = gobuffer__entries(&btf_kfunc_ranges);
> >  		ranges_cnt = gobuffer__nr_entries(&btf_kfunc_ranges);
> >  		found = false;
> >  		for (j = 0; j < ranges_cnt; j++) {
> >  			size_t addr = sym.st_value;
> >  
> >  			if (ranges[j].start <= addr && addr < ranges[j].end) {
> >  				found = true;
> >  				break;
> >  			}
> >  		}
> > +
> > +		printf("%s(%s): found=%d\n", __func__, func, found);
> > +
> >  		if (!found) {
> >  			free(func);
> >  			continue;
> >  		}
> >  
> >  		err = btf_encoder__tag_kfunc(encoder, &btf_funcs, func);
> >  		if (err) {
> >  			fprintf(stderr, "%s: failed to tag kfunc '%s'\n", __func__, func);
> >  			free(func);
> >  			goto out;
> >  		}
> >  		free(func);
> >  	}
> >  
> >  	err = 0;
> >  out:
> > 
> > --------------
> > 
> > The vmlinux I'm testing on has the kfuncs, etc, as we can see with:
> > 
> > ⬢[acme@toolbox pahole]$ readelf -sW vmlinux | grep __BTF_ID__func__ | wc -l
> > 517
> > ⬢[acme@toolbox pahole]$ readelf -sW vmlinux | grep __BTF_ID__func__ | tail
> >  97887: ffffffff83266bfc     4 OBJECT  LOCAL  DEFAULT   15 __BTF_ID__func__cubictcp_cong_avoid__805493
> >  97888: ffffffff83266c04     4 OBJECT  LOCAL  DEFAULT   15 __BTF_ID__func__cubictcp_state__806494
> >  97889: ffffffff83266c0c     4 OBJECT  LOCAL  DEFAULT   15 __BTF_ID__func__cubictcp_cwnd_event__807495
> >  97890: ffffffff83266c14     4 OBJECT  LOCAL  DEFAULT   15 __BTF_ID__func__cubictcp_acked__808496
> >  98068: ffffffff83266c24     4 OBJECT  LOCAL  DEFAULT   15 __BTF_ID__func__tcp_reno_ssthresh__773199
> >  98069: ffffffff83266c2c     4 OBJECT  LOCAL  DEFAULT   15 __BTF_ID__func__tcp_reno_cong_avoid__774200
> >  98070: ffffffff83266c34     4 OBJECT  LOCAL  DEFAULT   15 __BTF_ID__func__tcp_reno_undo_cwnd__775201
> >  98071: ffffffff83266c3c     4 OBJECT  LOCAL  DEFAULT   15 __BTF_ID__func__tcp_slow_start__776202
> >  98072: ffffffff83266c44     4 OBJECT  LOCAL  DEFAULT   15 __BTF_ID__func__tcp_cong_avoid_ai__777203
> > 101522: ffffffff83266c5c     4 OBJECT  LOCAL  DEFAULT   15 __BTF_ID__func__update_socket_protocol__80024
> > ⬢[acme@toolbox pahole]$
> > 
> > 
> > So that btf_encoder__tag_kfuncs() isn't finding any?
> > 
> > $ pahole -j --btf_features=decl_tag,decl_tag_kfuncs --btf_encode_detached=vmlinux.btf.decl_tag,decl_tag_kfuncs vmlinux
> > btf_encoder__tag_kfuncs(vmlinux)
> > 
> > Yeah, getting the source filename, the right one.
> > 
> > Then is_sym_kfunc_set() never returns true... But:
> > 
> > ⬢[acme@toolbox pahole]$ time pahole -j --btf_features=decl_tag,decl_tag_kfuncs --btf_encode_detached=vmlinux.btf.decl_tag,decl_tag_kfuncs vmlinux
> > is_sym_kfunc_set(__BTF_ID__set8__bpf_rstat_kfunc_ids, BTF_ID_SET8_PFX=__BTF_ID__set8__)
> > is_sym_kfunc_set(__BTF_ID__set8__key_sig_kfunc_set, BTF_ID_SET8_PFX=__BTF_ID__set8__)
> > is_sym_kfunc_set(__BTF_ID__set8__generic_btf_ids, BTF_ID_SET8_PFX=__BTF_ID__set8__)
> > is_sym_kfunc_set(__BTF_ID__set8__common_btf_ids, BTF_ID_SET8_PFX=__BTF_ID__set8__)
> > is_sym_kfunc_set(__BTF_ID__set8__bpf_map_iter_kfunc_ids, BTF_ID_SET8_PFX=__BTF_ID__set8__)
> > is_sym_kfunc_set(__BTF_ID__set8__cpumask_kfunc_btf_ids, BTF_ID_SET8_PFX=__BTF_ID__set8__)
> > is_sym_kfunc_set(__BTF_ID__set8__hid_bpf_kfunc_ids, BTF_ID_SET8_PFX=__BTF_ID__set8__)
> > is_sym_kfunc_set(__BTF_ID__set8__hid_bpf_fmodret_ids, BTF_ID_SET8_PFX=__BTF_ID__set8__)
> > is_sym_kfunc_set(__BTF_ID__set8__hid_bpf_syscall_kfunc_ids, BTF_ID_SET8_PFX=__BTF_ID__set8__)
> > is_sym_kfunc_set(__BTF_ID__set8__bpf_kfunc_check_set_skb, BTF_ID_SET8_PFX=__BTF_ID__set8__)
> > is_sym_kfunc_set(__BTF_ID__set8__bpf_kfunc_check_set_xdp, BTF_ID_SET8_PFX=__BTF_ID__set8__)
> > is_sym_kfunc_set(__BTF_ID__set8__bpf_kfunc_check_set_sock_addr, BTF_ID_SET8_PFX=__BTF_ID__set8__)
> > is_sym_kfunc_set(__BTF_ID__set8__bpf_sk_iter_kfunc_ids, BTF_ID_SET8_PFX=__BTF_ID__set8__)
> > is_sym_kfunc_set(__BTF_ID__set8__xdp_metadata_kfunc_ids, BTF_ID_SET8_PFX=__BTF_ID__set8__)
> > is_sym_kfunc_set(__BTF_ID__set8__bpf_test_modify_return_ids, BTF_ID_SET8_PFX=__BTF_ID__set8__)
> > is_sym_kfunc_set(__BTF_ID__set8__test_sk_check_kfunc_ids, BTF_ID_SET8_PFX=__BTF_ID__set8__)
> > is_sym_kfunc_set(__BTF_ID__set8__tcp_cubic_check_kfunc_ids, BTF_ID_SET8_PFX=__BTF_ID__set8__)
> > is_sym_kfunc_set(__BTF_ID__set8__bpf_tcp_ca_check_kfunc_ids, BTF_ID_SET8_PFX=__BTF_ID__set8__)
> > is_sym_kfunc_set(__BTF_ID__set8__bpf_mptcp_fmodret_ids, BTF_ID_SET8_PFX=__BTF_ID__set8__)
> > 
> > real	0m5.586s
> > user	0m29.707s
> > sys	0m2.160s
> > ⬢[acme@toolbox pahole]$
> > 
> > And then:
> > 
> > ⬢[acme@toolbox pahole]$ time pahole -j --btf_features=decl_tag,decl_tag_kfuncs --btf_encode_detached=vmlinux.btf.decl_tag,decl_tag_kfuncs vmlinux
> > is_sym_kfunc_set(__BTF_ID__set8__bpf_rstat_kfunc_ids, BTF_ID_SET8_PFX=__BTF_ID__set8__, set->flags= 0, BTF_SET8_KFUNCS=1, ret=0)
> > is_sym_kfunc_set(__BTF_ID__set8__key_sig_kfunc_set, BTF_ID_SET8_PFX=__BTF_ID__set8__, set->flags= 0, BTF_SET8_KFUNCS=1, ret=0)
> > is_sym_kfunc_set(__BTF_ID__set8__generic_btf_ids, BTF_ID_SET8_PFX=__BTF_ID__set8__, set->flags= 0, BTF_SET8_KFUNCS=1, ret=0)
> > is_sym_kfunc_set(__BTF_ID__set8__common_btf_ids, BTF_ID_SET8_PFX=__BTF_ID__set8__, set->flags= 0, BTF_SET8_KFUNCS=1, ret=0)
> > is_sym_kfunc_set(__BTF_ID__set8__bpf_map_iter_kfunc_ids, BTF_ID_SET8_PFX=__BTF_ID__set8__, set->flags= 0, BTF_SET8_KFUNCS=1, ret=0)
> > is_sym_kfunc_set(__BTF_ID__set8__cpumask_kfunc_btf_ids, BTF_ID_SET8_PFX=__BTF_ID__set8__, set->flags= 0, BTF_SET8_KFUNCS=1, ret=0)
> > is_sym_kfunc_set(__BTF_ID__set8__hid_bpf_kfunc_ids, BTF_ID_SET8_PFX=__BTF_ID__set8__, set->flags= 0, BTF_SET8_KFUNCS=1, ret=0)
> > is_sym_kfunc_set(__BTF_ID__set8__hid_bpf_fmodret_ids, BTF_ID_SET8_PFX=__BTF_ID__set8__, set->flags= 0, BTF_SET8_KFUNCS=1, ret=0)
> > is_sym_kfunc_set(__BTF_ID__set8__hid_bpf_syscall_kfunc_ids, BTF_ID_SET8_PFX=__BTF_ID__set8__, set->flags= 0, BTF_SET8_KFUNCS=1, ret=0)
> > is_sym_kfunc_set(__BTF_ID__set8__bpf_kfunc_check_set_skb, BTF_ID_SET8_PFX=__BTF_ID__set8__, set->flags= 0, BTF_SET8_KFUNCS=1, ret=0)
> > is_sym_kfunc_set(__BTF_ID__set8__bpf_kfunc_check_set_xdp, BTF_ID_SET8_PFX=__BTF_ID__set8__, set->flags= 0, BTF_SET8_KFUNCS=1, ret=0)
> > is_sym_kfunc_set(__BTF_ID__set8__bpf_kfunc_check_set_sock_addr, BTF_ID_SET8_PFX=__BTF_ID__set8__, set->flags= 0, BTF_SET8_KFUNCS=1, ret=0)
> > is_sym_kfunc_set(__BTF_ID__set8__bpf_sk_iter_kfunc_ids, BTF_ID_SET8_PFX=__BTF_ID__set8__, set->flags= 0, BTF_SET8_KFUNCS=1, ret=0)
> > is_sym_kfunc_set(__BTF_ID__set8__xdp_metadata_kfunc_ids, BTF_ID_SET8_PFX=__BTF_ID__set8__, set->flags= 0, BTF_SET8_KFUNCS=1, ret=0)
> > is_sym_kfunc_set(__BTF_ID__set8__bpf_test_modify_return_ids, BTF_ID_SET8_PFX=__BTF_ID__set8__, set->flags= 0, BTF_SET8_KFUNCS=1, ret=0)
> > is_sym_kfunc_set(__BTF_ID__set8__test_sk_check_kfunc_ids, BTF_ID_SET8_PFX=__BTF_ID__set8__, set->flags= 0, BTF_SET8_KFUNCS=1, ret=0)
> > is_sym_kfunc_set(__BTF_ID__set8__tcp_cubic_check_kfunc_ids, BTF_ID_SET8_PFX=__BTF_ID__set8__, set->flags= 0, BTF_SET8_KFUNCS=1, ret=0)
> > is_sym_kfunc_set(__BTF_ID__set8__bpf_tcp_ca_check_kfunc_ids, BTF_ID_SET8_PFX=__BTF_ID__set8__, set->flags= 0, BTF_SET8_KFUNCS=1, ret=0)
> > is_sym_kfunc_set(__BTF_ID__set8__bpf_mptcp_fmodret_ids, BTF_ID_SET8_PFX=__BTF_ID__set8__, set->flags= 0, BTF_SET8_KFUNCS=1, ret=0)
> 
> set->flags=0 here is odd. I'd expect at least some of those to be
> non-zero. Can you check if your tree has
> https://github.com/torvalds/linux/commit/6f3189f38a3e995232e028a4c341164c4aca1b20
> ?

⬢[acme@toolbox linux]$ git tag --contains 6f3189f38a3e995232e028a4c341164c4aca1b20
v6.9-rc1
v6.9-rc2
v6.9-rc3
v6.9-rc4
v6.9-rc5
v6.9-rc6
v6.9-rc7
⬢[acme@toolbox linux]$ git log --oneline -1
dd5a440a31fae6e4 (HEAD, tag: v6.9-rc7, torvalds/master) Linux 6.9-rc7
⬢[acme@toolbox linux]$

So now with a just built upstream kernel I get the output below, do you
have patches for other tools to consume this? Or does, say, bpftrace
already handles such decl tags, etc?

I think I'll make pfunct (its in the pahole git repo) to consume it:

⬢[acme@toolbox pahole]$ pfunct --help
Usage: pfunct [OPTION...] FILE

  -a, --addr=ADDR            show just the function that where ADDR is
  -b, --expand_types         Expand types needed by the prototype
      --compile[=FUNCTION]   Generate compilable source code with types
                             expanded (Default all functions)
  -c, --class=CLASS          functions that have CLASS pointer parameters
  -E, --externals            show just external functions
  -f, --function=FUNCTION    show just FUNCTION
  -F, --format_path=FORMAT_LIST   List of debugging formats to try
  -g, --goto_labels          show number of goto labels
  -G, --cc_uninlined         declared inline, uninlined by compiler
  -H, --cc_inlined           not declared inline, inlined by compiler
  -i, --inline_expansions    show inline expansions
  -I, --inline_expansions_stats   show inline expansions stats
  -l, --decl_info            show source code info
      --no_parm_names        Don't show parameter names
  -N, --function_name_len    show size of functions names
  -p, --nr_parms             show number of parameters
  -P, --prototypes           show function prototypes
      --symtab[=NAME]        show symbol table NAME (Default .symtab)
  -s, --sizes                show size of functions
  -S, --nr_variables         show number of variables
  -t, --total_inline_stats   show Multi-CU total inline expansions stats
  -T, --variables            show variables
  -V, --verbose              be verbose
  -?, --help                 Give this help list
      --usage                Give a short usage message
      --version              Print program version

Mandatory or optional arguments to long options are also mandatory or optional
for any corresponding short options.
⬢[acme@toolbox pahole]$

- Arnaldo

⬢[acme@toolbox pahole]$ time pahole -j --btf_features=decl_tag,decl_tag_kfuncs --btf_encode_detached=vmlinux.btf.decl_tag,decl_tag_kfuncs vmlinux-v6.9.0-rc7

real	0m5.938s
user	0m32.050s
sys	0m2.075s
⬢[acme@toolbox pahole]$ bpftool btf dump file vmlinux.btf.decl_tag,decl_tag_kfuncs | grep -w 94151
[94151] FUNC 'cgroup_rstat_updated' type_id=94150 linkage=static
[135450] DECL_TAG 'bpf_kfunc' type_id=94151 component_idx=-1
⬢[acme@toolbox pahole]$ bpftool btf dump file vmlinux.btf.decl_tag,decl_tag_kfuncs | grep -w 94150 -A2
[94150] FUNC_PROTO '(anon)' ret_type_id=0 vlen=2
	'cgrp' type_id=744
	'cpu' type_id=12
[94151] FUNC 'cgroup_rstat_updated' type_id=94150 linkage=static
[94152] STRUCT 'pids_cgroup' size=288 vlen=6
	'css' type_id=1786 bits_offset=0
⬢[acme@toolbox pahole]$
⬢[acme@toolbox pahole]$ bpftool btf dump file vmlinux.btf.decl_tag,decl_tag_kfuncs  | grep DECL
	'BTF_KIND_DECL_TAG' val=17
[135450] DECL_TAG 'bpf_kfunc' type_id=94151 component_idx=-1
[135451] DECL_TAG 'bpf_kfunc' type_id=94146 component_idx=-1
[135452] DECL_TAG 'bpf_kfunc' type_id=74311 component_idx=-1
[135453] DECL_TAG 'bpf_kfunc' type_id=74309 component_idx=-1
[135454] DECL_TAG 'bpf_kfunc' type_id=74307 component_idx=-1
[135455] DECL_TAG 'bpf_kfunc' type_id=74305 component_idx=-1
[135456] DECL_TAG 'bpf_kfunc' type_id=74302 component_idx=-1
[135457] DECL_TAG 'bpf_kfunc' type_id=43681 component_idx=-1
[135458] DECL_TAG 'bpf_kfunc' type_id=83157 component_idx=-1
[135459] DECL_TAG 'bpf_kfunc' type_id=83156 component_idx=-1
[135460] DECL_TAG 'bpf_kfunc' type_id=83152 component_idx=-1
[135461] DECL_TAG 'bpf_kfunc' type_id=83151 component_idx=-1
[135462] DECL_TAG 'bpf_kfunc' type_id=83149 component_idx=-1
[135463] DECL_TAG 'bpf_kfunc' type_id=83145 component_idx=-1
[135464] DECL_TAG 'bpf_kfunc' type_id=83144 component_idx=-1
[135465] DECL_TAG 'bpf_kfunc' type_id=83142 component_idx=-1
[135466] DECL_TAG 'bpf_kfunc' type_id=83141 component_idx=-1
[135467] DECL_TAG 'bpf_kfunc' type_id=83133 component_idx=-1
[135468] DECL_TAG 'bpf_kfunc' type_id=83132 component_idx=-1
[135469] DECL_TAG 'bpf_kfunc' type_id=83139 component_idx=-1
[135470] DECL_TAG 'bpf_kfunc' type_id=83137 component_idx=-1
[135471] DECL_TAG 'bpf_kfunc' type_id=83135 component_idx=-1
[135472] DECL_TAG 'bpf_kfunc' type_id=83130 component_idx=-1
[135473] DECL_TAG 'bpf_kfunc' type_id=83128 component_idx=-1
[135474] DECL_TAG 'bpf_kfunc' type_id=83125 component_idx=-1
[135475] DECL_TAG 'bpf_kfunc' type_id=83123 component_idx=-1
[135476] DECL_TAG 'bpf_kfunc' type_id=83121 component_idx=-1
[135477] DECL_TAG 'bpf_kfunc' type_id=83119 component_idx=-1
[135478] DECL_TAG 'bpf_kfunc' type_id=83117 component_idx=-1
[135479] DECL_TAG 'bpf_kfunc' type_id=83095 component_idx=-1
[135480] DECL_TAG 'bpf_kfunc' type_id=83103 component_idx=-1
[135481] DECL_TAG 'bpf_kfunc' type_id=83101 component_idx=-1
[135482] DECL_TAG 'bpf_kfunc' type_id=83099 component_idx=-1
[135483] DECL_TAG 'bpf_kfunc' type_id=83098 component_idx=-1
[135484] DECL_TAG 'bpf_kfunc' type_id=83115 component_idx=-1
[135485] DECL_TAG 'bpf_kfunc' type_id=83114 component_idx=-1
[135486] DECL_TAG 'bpf_kfunc' type_id=24936 component_idx=-1
[135487] DECL_TAG 'bpf_kfunc' type_id=24934 component_idx=-1
[135488] DECL_TAG 'bpf_kfunc' type_id=24932 component_idx=-1
[135489] DECL_TAG 'bpf_kfunc' type_id=35395 component_idx=-1
[135490] DECL_TAG 'bpf_kfunc' type_id=35393 component_idx=-1
[135491] DECL_TAG 'bpf_kfunc' type_id=35391 component_idx=-1
[135492] DECL_TAG 'bpf_kfunc' type_id=35389 component_idx=-1
[135493] DECL_TAG 'bpf_kfunc' type_id=35387 component_idx=-1
[135494] DECL_TAG 'bpf_kfunc' type_id=35385 component_idx=-1
[135495] DECL_TAG 'bpf_kfunc' type_id=129497 component_idx=-1
[135496] DECL_TAG 'bpf_kfunc' type_id=129495 component_idx=-1
[135497] DECL_TAG 'bpf_kfunc' type_id=129493 component_idx=-1
[135498] DECL_TAG 'bpf_kfunc' type_id=35383 component_idx=-1
[135499] DECL_TAG 'bpf_kfunc' type_id=35381 component_idx=-1
[135500] DECL_TAG 'bpf_kfunc' type_id=35379 component_idx=-1
[135501] DECL_TAG 'bpf_kfunc' type_id=83112 component_idx=-1
[135502] DECL_TAG 'bpf_kfunc' type_id=83110 component_idx=-1
[135503] DECL_TAG 'bpf_kfunc' type_id=83109 component_idx=-1
[135504] DECL_TAG 'bpf_kfunc' type_id=83107 component_idx=-1
[135505] DECL_TAG 'bpf_kfunc' type_id=83105 component_idx=-1
[135506] DECL_TAG 'bpf_kfunc' type_id=129409 component_idx=-1
[135507] DECL_TAG 'bpf_kfunc' type_id=119719 component_idx=-1
[135508] DECL_TAG 'bpf_kfunc' type_id=119717 component_idx=-1
[135509] DECL_TAG 'bpf_kfunc' type_id=83434 component_idx=-1
[135510] DECL_TAG 'bpf_kfunc' type_id=83430 component_idx=-1
[135511] DECL_TAG 'bpf_kfunc' type_id=83432 component_idx=-1
[135512] DECL_TAG 'bpf_kfunc' type_id=83427 component_idx=-1
[135513] DECL_TAG 'bpf_kfunc' type_id=83426 component_idx=-1
[135514] DECL_TAG 'bpf_kfunc' type_id=83425 component_idx=-1
[135515] DECL_TAG 'bpf_kfunc' type_id=83424 component_idx=-1
[135516] DECL_TAG 'bpf_kfunc' type_id=83423 component_idx=-1
[135517] DECL_TAG 'bpf_kfunc' type_id=83421 component_idx=-1
[135518] DECL_TAG 'bpf_kfunc' type_id=83419 component_idx=-1
[135519] DECL_TAG 'bpf_kfunc' type_id=83418 component_idx=-1
[135520] DECL_TAG 'bpf_kfunc' type_id=83416 component_idx=-1
[135521] DECL_TAG 'bpf_kfunc' type_id=83415 component_idx=-1
[135522] DECL_TAG 'bpf_kfunc' type_id=83413 component_idx=-1
[135523] DECL_TAG 'bpf_kfunc' type_id=83411 component_idx=-1
[135524] DECL_TAG 'bpf_kfunc' type_id=83410 component_idx=-1
[135525] DECL_TAG 'bpf_kfunc' type_id=83408 component_idx=-1
[135526] DECL_TAG 'bpf_kfunc' type_id=83407 component_idx=-1
[135527] DECL_TAG 'bpf_kfunc' type_id=83406 component_idx=-1
[135528] DECL_TAG 'bpf_kfunc' type_id=83404 component_idx=-1
[135529] DECL_TAG 'bpf_kfunc' type_id=83403 component_idx=-1
[135530] DECL_TAG 'bpf_kfunc' type_id=83401 component_idx=-1
[135531] DECL_TAG 'bpf_kfunc' type_id=83399 component_idx=-1
[135532] DECL_TAG 'bpf_kfunc' type_id=83398 component_idx=-1
[135533] DECL_TAG 'bpf_kfunc' type_id=83396 component_idx=-1
[135534] DECL_TAG 'bpf_kfunc' type_id=84592 component_idx=-1
[135535] DECL_TAG 'bpf_kfunc' type_id=78862 component_idx=-1
[135536] DECL_TAG 'bpf_kfunc' type_id=78855 component_idx=-1
[135537] DECL_TAG 'bpf_kfunc' type_id=78853 component_idx=-1
[135538] DECL_TAG 'bpf_kfunc' type_id=78851 component_idx=-1
[135539] DECL_TAG 'bpf_kfunc' type_id=78849 component_idx=-1
[135540] DECL_TAG 'bpf_kfunc' type_id=52826 component_idx=-1
[135541] DECL_TAG 'bpf_kfunc' type_id=52825 component_idx=-1
[135542] DECL_TAG 'bpf_kfunc' type_id=52823 component_idx=-1
[135543] DECL_TAG 'bpf_kfunc' type_id=52821 component_idx=-1
[135544] DECL_TAG 'bpf_kfunc' type_id=52816 component_idx=-1
[135545] DECL_TAG 'bpf_kfunc' type_id=79148 component_idx=-1
[135546] DECL_TAG 'bpf_kfunc' type_id=79146 component_idx=-1
[135547] DECL_TAG 'bpf_kfunc' type_id=79144 component_idx=-1
[135548] DECL_TAG 'bpf_kfunc' type_id=33070 component_idx=-1
[135549] DECL_TAG 'bpf_kfunc' type_id=33068 component_idx=-1
[135550] DECL_TAG 'bpf_kfunc' type_id=33088 component_idx=-1
[135551] DECL_TAG 'bpf_kfunc' type_id=33064 component_idx=-1
[135552] DECL_TAG 'bpf_kfunc' type_id=33061 component_idx=-1
[135553] DECL_TAG 'bpf_kfunc' type_id=134975 component_idx=-1
[135554] DECL_TAG 'bpf_kfunc' type_id=134971 component_idx=-1
[135555] DECL_TAG 'bpf_kfunc' type_id=134972 component_idx=-1
[135556] DECL_TAG 'bpf_kfunc' type_id=134970 component_idx=-1
[135557] DECL_TAG 'bpf_kfunc' type_id=134974 component_idx=-1
[135558] DECL_TAG 'bpf_kfunc' type_id=134969 component_idx=-1
[135559] DECL_TAG 'bpf_kfunc' type_id=53825 component_idx=-1
[135560] DECL_TAG 'bpf_kfunc' type_id=53827 component_idx=-1
[135561] DECL_TAG 'bpf_kfunc' type_id=53824 component_idx=-1
[135562] DECL_TAG 'bpf_kfunc' type_id=53831 component_idx=-1
[135563] DECL_TAG 'bpf_kfunc' type_id=53829 component_idx=-1
[135564] DECL_TAG 'bpf_kfunc' type_id=21317 component_idx=-1
[135565] DECL_TAG 'bpf_kfunc' type_id=21315 component_idx=-1
⬢[acme@toolbox pahole]$

