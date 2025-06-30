Return-Path: <bpf+bounces-61831-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBF08AEDF96
	for <lists+bpf@lfdr.de>; Mon, 30 Jun 2025 15:52:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93BD9170E46
	for <lists+bpf@lfdr.de>; Mon, 30 Jun 2025 13:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7646C28B7DC;
	Mon, 30 Jun 2025 13:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L9AeVr0o"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC35528B509;
	Mon, 30 Jun 2025 13:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751291519; cv=none; b=FflXNfwmLy+yhG0SpiR6gth2Kgz48NN1mRGK7lduS3/eIqFVfCkKzVE49sUElcO4Khisqrf8KiyK8w+8dm3dxr4jF0hyr1CN6LiWAgE3sj7xQ2FOX3COVUM8vrFFOcgWocYcqrC0swcZ/c2YzezLuLqp6w7FLSu2SXMKGuRNmv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751291519; c=relaxed/simple;
	bh=wNNgEq/xwlk11ZMpaDLYYleGLte2Q65VoTTDNw+hlPg=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KMeav4sZ5a9Ttx/MeCvWTT9/pzuP70YvaW85wyKnpFUp1ciFWJo/Dhyra1nK5wRIpd6Vf2OUCnuVQVjd4ABWvrt/OpXN+At7MZOrx+8E4qKpSwhkvOluBWfHkwRUMPW/LJRM8xHUUFGv6FGR0GH8buPrPsxpO4qMdrezyHKeCTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L9AeVr0o; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ade5a0442dfso858897166b.1;
        Mon, 30 Jun 2025 06:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751291515; x=1751896315; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=REVr/cDG67uUflWllwAeE265eP60w4H4ZvLguLfhXg0=;
        b=L9AeVr0oGipZpkG35l2GoCeCX2UfgUE/xHHAx7O9wtzzaNAsUFPtHTcynCl+/Jn1Ym
         /Tkx5Ctr3vHGOZlyBmEM+v1n20z7Rdv3YByyF66+z1eONrE+FUxFaVpC2rOLRdKGSo+X
         jliQVc7nMIdo75NNwmohBot1hWsbRGR/eNOcLrAcEYfNBq9atobjXjs/SVPD14lTk6JF
         rV+XiUCfOx0tCQGK16HgoNS7Tb5va2pszTOQb9koZEdxn3k6JsNx1P0zWV3kHZ0jI9cH
         3zu6QD6epFWSfl8d68vRUq9zMZ2iQlY+Sa0w8lLf+lGalWd02PCidyS+bYJAvHTwp+zV
         C7UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751291515; x=1751896315;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=REVr/cDG67uUflWllwAeE265eP60w4H4ZvLguLfhXg0=;
        b=mGdjSGiR0JiOn7AkiCde3LdqP16+MNTg9ZBU4UM6KexK3/LcmjQEsebxrFKrJa5r3f
         YIrfgYfV2XGU9xAzYTmqMgWo2S4yiZqo8L+aCtW/27Ie0zc3nQu335JlmFI5ABbPhGYi
         dmx37HbiWWfCdO/JVZ38PtRj1TcC3fVrsy8OEMtA76amqzfHUvYST2wjkedEZXENQlFs
         SAPAVMMFjdYAziNq99IJVlEQ0SBbZ5VDWmjpIeykDzoO6A66xamln1FKB/mVdwvyhv1I
         iSKmHw0Hb9FfTjMDd0aP50rOCZ6HfkrV07x+jUvuDagKXwTdiVY1g24VH/5roU+ajnIg
         MM7Q==
X-Forwarded-Encrypted: i=1; AJvYcCV6fnMivIhBvBHHDOqH1t1ddjR50awuljtADCqIqaeOU6TipqrS10Ub7Yl709C36/hi1V0=@vger.kernel.org, AJvYcCWGVYD+e1siyvCtptrYX93kaHMQNyNYI82ts01beArNDA0XIeTu6AFN9ZdDJzKasRptQkXb2l9c/g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwqMPJM7jDCJs8XvCSzWdaiTVk348tXxAOffC2xBVOuuVNz/DIH
	JvVAOxlQaHaPqJak1m8vPi0EwpWGj7a7HkhVbcZK1k38Fg4wnDtJuZWf
X-Gm-Gg: ASbGncsffQloBt9d34iIL0RcxNNkwywHuknTgzIOEtA9C77CBXs6yrIZhhWopH0Vaxg
	kp3wzn/F46rsSSFOOWK380anGWJoirCl7RuNRyxwfPF8Ib1PgaAP4Q0YYZtv3tw3CkR7aIz5Mhe
	wQ1UtSUtJ+aMJwV+x1YFjaJXA55GxqI3a2BvHBLq6rqAmOUifzCmqSmKF2T6egeAFQV0ff5xM5E
	kB2VmBrCxMqvnLylz0xGB1bBJfSl/Xkegvb4EyBDRaPhz5SxxTNoEYh/Kttzs87rE/Vpsq3IjFw
	C94esi5K9VmvnBIEQXAwk8kOTLiO7/+rr2k/iRaEDg5axM1b5n8nFeXloDQ=
X-Google-Smtp-Source: AGHT+IHEf12eGbkRBgLU0Kou4K2STQbU8qBWiWSeQo10mGjmCJdpZAS5LeecSsgptsvRLcfWp7iDEw==
X-Received: by 2002:a17:907:3f08:b0:ada:6adb:cca with SMTP id a640c23a62f3a-ae34fd3370cmr1258162166b.6.1751291514699;
        Mon, 30 Jun 2025 06:51:54 -0700 (PDT)
Received: from krava ([173.38.220.57])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae35363b1b9sm685094466b.12.2025.06.30.06.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 06:51:54 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 30 Jun 2025 15:51:52 +0200
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Tony Ambardar <tony.ambardar@gmail.com>, dwarves@vger.kernel.org,
	bpf@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexis =?iso-8859-1?Q?Lothor=E9?= <alexis.lothore@bootlin.com>
Subject: Re: [PATCH dwarves v3] dwarf_loader: Fix skipped encoding of
 function BTF on 32-bit systems
Message-ID: <aGKWeBSsboCsoNDB@krava>
References: <20250502070318.1561924-1-tony.ambardar@gmail.com>
 <20250522063719.1885902-1-tony.ambardar@gmail.com>
 <66861840-0d4e-4b83-a89c-3e56667ac55b@oracle.com>
 <7d0cb760-6745-4595-8e50-6f5cd8d0db05@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7d0cb760-6745-4595-8e50-6f5cd8d0db05@oracle.com>

On Mon, Jun 30, 2025 at 11:01:19AM +0100, Alan Maguire wrote:
> On 24/06/2025 17:14, Alan Maguire wrote:
> > On 22/05/2025 07:37, Tony Ambardar wrote:
> >> I encountered an issue building BTF kernels for 32-bit armhf, where many
> >> functions are missing in BTF data:
> >>
> >>   LD      vmlinux
> >>   BTFIDS  vmlinux
> >> WARN: resolve_btfids: unresolved symbol vfs_truncate
> >> WARN: resolve_btfids: unresolved symbol vfs_fallocate
> >> WARN: resolve_btfids: unresolved symbol scx_bpf_select_cpu_dfl
> >> WARN: resolve_btfids: unresolved symbol scx_bpf_pick_idle_cpu_node
> >> WARN: resolve_btfids: unresolved symbol scx_bpf_pick_idle_cpu
> >> WARN: resolve_btfids: unresolved symbol scx_bpf_pick_any_cpu_node
> >> WARN: resolve_btfids: unresolved symbol scx_bpf_pick_any_cpu
> >> WARN: resolve_btfids: unresolved symbol scx_bpf_kick_cpu
> >> WARN: resolve_btfids: unresolved symbol scx_bpf_exit_bstr
> >> WARN: resolve_btfids: unresolved symbol scx_bpf_dsq_nr_queued
> >> WARN: resolve_btfids: unresolved symbol scx_bpf_dsq_move_vtime
> >> WARN: resolve_btfids: unresolved symbol scx_bpf_dsq_move_to_local
> >> WARN: resolve_btfids: unresolved symbol scx_bpf_dsq_move
> >> WARN: resolve_btfids: unresolved symbol scx_bpf_dsq_insert_vtime
> >> WARN: resolve_btfids: unresolved symbol scx_bpf_dsq_insert
> >> WARN: resolve_btfids: unresolved symbol scx_bpf_dispatch_vtime_from_dsq
> >> WARN: resolve_btfids: unresolved symbol scx_bpf_dispatch_vtime
> >> WARN: resolve_btfids: unresolved symbol scx_bpf_dispatch_from_dsq_set_vtime
> >> WARN: resolve_btfids: unresolved symbol scx_bpf_dispatch_from_dsq_set_slice
> >> WARN: resolve_btfids: unresolved symbol scx_bpf_dispatch_from_dsq
> >> WARN: resolve_btfids: unresolved symbol scx_bpf_dispatch
> >> WARN: resolve_btfids: unresolved symbol scx_bpf_destroy_dsq
> >> WARN: resolve_btfids: unresolved symbol scx_bpf_create_dsq
> >> WARN: resolve_btfids: unresolved symbol scx_bpf_consume
> >> WARN: resolve_btfids: unresolved symbol bpf_throw
> >> WARN: resolve_btfids: unresolved symbol bpf_sock_ops_enable_tx_tstamp
> >> WARN: resolve_btfids: unresolved symbol bpf_percpu_obj_new_impl
> >> WARN: resolve_btfids: unresolved symbol bpf_obj_new_impl
> >> WARN: resolve_btfids: unresolved symbol bpf_lookup_user_key
> >> WARN: resolve_btfids: unresolved symbol bpf_lookup_system_key
> >> WARN: resolve_btfids: unresolved symbol bpf_iter_task_vma_new
> >> WARN: resolve_btfids: unresolved symbol bpf_iter_scx_dsq_new
> >> WARN: resolve_btfids: unresolved symbol bpf_get_kmem_cache
> >> WARN: resolve_btfids: unresolved symbol bpf_dynptr_from_xdp
> >> WARN: resolve_btfids: unresolved symbol bpf_dynptr_from_skb
> >> WARN: resolve_btfids: unresolved symbol bpf_cgroup_from_id
> >>   NM      System.map
> >>
> >> After further debugging this can be reproduced more simply:
> >>
> >> $ pahole -J -j --btf_features=decl_tag,consistent_func,decl_tag_kfuncs .tmp_vmlinux_armhf
> >> btf_encoder__tag_kfunc: failed to find kfunc 'scx_bpf_select_cpu_dfl' in BTF
> >> btf_encoder__tag_kfuncs: failed to tag kfunc 'scx_bpf_select_cpu_dfl'
> >>
> >> $ pfunct -Fbtf -E -f scx_bpf_select_cpu_dfl .tmp_vmlinux_armhf
> >> <nothing>
> >>
> >> $ pfunct -Fdwarf -E -f scx_bpf_select_cpu_dfl .tmp_vmlinux_armhf
> >> s32 scx_bpf_select_cpu_dfl(struct task_struct * p, s32 prev_cpu, u64 wake_flags, bool * is_idle);
> >>
> >> $ pahole -J -j --btf_features=decl_tag,decl_tag_kfuncs .tmp_vmlinux_armhf
> >>
> >> $ pfunct -Fbtf -E -f scx_bpf_select_cpu_dfl .tmp_vmlinux_armhf
> >> bpf_kfunc s32 scx_bpf_select_cpu_dfl(struct task_struct * p, s32 prev_cpu, u64 wake_flags, bool * is_idle);
> >>
> >> The key things to note are the pahole 'consistent_func' feature and the u64
> >> 'wake_flags' parameter vs. arm 32-bit registers. These point to existing
> >> code handling arguments larger than register-size, allowing them to be
> >> BTF encoded but only if structs.
> >>
> >> Generalize the code for any argument type larger than register size (i.e.
> >> size > cu->addr_size). This should work for integral or aggregate types,
> >> and also avoids a bug in the current code where a register-sized struct
> >> could be mistaken for larger. Note that zero-sized arguments will still
> >> be marked as inconsistent and not encoded.
> >>
> >> Fixes: a53c58158b76 ("dwarf_loader: Mark functions that do not use expected registers for params")
> >> Tested-by: Alexis Lothoré <alexis.lothore@bootlin.com>
> >> Tested-by: Alan Maguire <alan.maguire@oracle.com>
> >> Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>
> > 
> > hi Tony,
> > 
> > I'm planning on landing this shortly unless anyone objects; and on that
> > topic if anyone has the cycles to test with this patch that would be
> > great! I ran it through the work-in-progress BTF comparison in github CI
> > and all looks good; see the "Compare functions generated" step in [1].
> > 
> > Thanks!
> >
> 
> In fact I spoke too soon; there was a bug in the function comparison.
> After that was fixed, I reran with this patch; see [1].
> 
> It shows that - as expected - functions with 0-sized params are left
> out, specifically
> 
> < int __io_run_local_work(struct io_ring_ctx * ctx, io_tw_token_t tw,
> int min_events, int max_events);
> < int __io_run_local_work_loop(struct llist_node * * node, io_tw_token_t
> tw, int events);
> 
> We expect this since io_tw_token_t is 0-sized. However on x86_64 it did
> show one _extra_ function that I didn't expect:
> 
> > int __vxlan_fdb_delete(struct vxlan_dev * vxlan, const unsigned char
> * addr, union vxlan_addr ip, __be16 port, __be32 src_vni, __be32 vni,
> u32 ifindex, bool swdev_notify);
> 
> It's not clear to me why that function was added with this change - I
> would have expected it either with or without the change. Any idea why
> that might be?

hi,
I can see that as well, IIUC the 'ip' argument is:

union vxlan_addr {
        struct sockaddr_in sin;
        struct sockaddr_in6 sin6;
        struct sockaddr sa;
};

so we have struct as 4th argument, which sets the has_wide_param condition
and won't set the fn->proto.unexpected_reg for the function, because of:

   if (!has_wide_param)
      fn->proto.unexpected_reg = 1;

I'm not sure it's correct.. if the ip struct is big enough that it's passed
on stack, why are the rest of the arguments marked with unexpected_reg
(in parameter__new) I think I'm missing something

jirka


> 
> [1]
> https://github.com/alan-maguire/dwarves/actions/runs/15872520906/job/44752273776
> 
> > Alan
> > 
> > [1] https://github.com/alan-maguire/dwarves/actions/runs/15854137212
> > 
> >> ---
> >> v2 -> v3:
> >>  - Added Tested-by: from Alexis and Alan.
> >>  - Revert support for encoding 0-sized structs (as v1) after discussion:
> >>    https://lore.kernel.org/dwarves/9a41b21f-c0ae-4298-bf95-09d0cdc3f3ab@oracle.com/
> >>  - Inline param__is_wide() and clarify some naming/wording.
> >>
> >> v1 -> v2:
> >>  - Update to preserve existing behaviour where zero-sized struct params
> >>    still permit the function to be encoded, as noted by Alan.
> >>
> >> ---
> >>  dwarf_loader.c | 37 ++++++++++++-------------------------
> >>  1 file changed, 12 insertions(+), 25 deletions(-)
> >>
> >> diff --git a/dwarf_loader.c b/dwarf_loader.c
> >> index e1ba7bc..134a76b 100644
> >> --- a/dwarf_loader.c
> >> +++ b/dwarf_loader.c
> >> @@ -2914,23 +2914,9 @@ out:
> >>  	return 0;
> >>  }
> >>  
> >> -static bool param__is_struct(struct cu *cu, struct tag *tag)
> >> +static inline bool param__is_wide(struct cu *cu, struct tag *tag)
> >>  {
> >> -	struct tag *type = cu__type(cu, tag->type);
> >> -
> >> -	if (!type)
> >> -		return false;
> >> -
> >> -	switch (type->tag) {
> >> -	case DW_TAG_structure_type:
> >> -		return true;
> >> -	case DW_TAG_const_type:
> >> -	case DW_TAG_typedef:
> >> -		/* handle "typedef struct", const parameter */
> >> -		return param__is_struct(cu, type);
> >> -	default:
> >> -		return false;
> >> -	}
> >> +	return tag__size(tag, cu) > cu->addr_size;
> >>  }
> >>  
> >>  static int cu__resolve_func_ret_types_optimized(struct cu *cu)
> >> @@ -2942,9 +2928,9 @@ static int cu__resolve_func_ret_types_optimized(struct cu *cu)
> >>  		struct tag *tag = pt->entries[i];
> >>  		struct parameter *pos;
> >>  		struct function *fn = tag__function(tag);
> >> -		bool has_unexpected_reg = false, has_struct_param = false;
> >> +		bool has_unexpected_reg = false, has_wide_param = false;
> >>  
> >> -		/* mark function as optimized if parameter is, or
> >> +		/* Mark function as optimized if parameter is, or
> >>  		 * if parameter does not have a location; at this
> >>  		 * point location presence has been marked in
> >>  		 * abstract origins for cases where a parameter
> >> @@ -2953,10 +2939,11 @@ static int cu__resolve_func_ret_types_optimized(struct cu *cu)
> >>  		 *
> >>  		 * Also mark functions which, due to optimization,
> >>  		 * use an unexpected register for a parameter.
> >> -		 * Exception is functions which have a struct
> >> -		 * as a parameter, as multiple registers may
> >> -		 * be used to represent it, throwing off register
> >> -		 * to parameter mapping.
> >> +		 * Exception is functions with a wide parameter,
> >> +		 * as single register won't be used to represent
> >> +		 * it, throwing off register to parameter mapping.
> >> +		 * Examples include large structs or 64-bit types
> >> +		 * on a 32-bit arch.
> >>  		 */
> >>  		ftype__for_each_parameter(&fn->proto, pos) {
> >>  			if (pos->optimized || !pos->has_loc)
> >> @@ -2967,11 +2954,11 @@ static int cu__resolve_func_ret_types_optimized(struct cu *cu)
> >>  		}
> >>  		if (has_unexpected_reg) {
> >>  			ftype__for_each_parameter(&fn->proto, pos) {
> >> -				has_struct_param = param__is_struct(cu, &pos->tag);
> >> -				if (has_struct_param)
> >> +				has_wide_param = param__is_wide(cu, &pos->tag);
> >> +				if (has_wide_param)
> >>  					break;
> >>  			}
> >> -			if (!has_struct_param)
> >> +			if (!has_wide_param)
> >>  				fn->proto.unexpected_reg = 1;
> >>  		}
> >>  
> > 
> > 
> 
> 

