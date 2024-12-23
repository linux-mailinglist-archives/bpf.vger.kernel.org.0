Return-Path: <bpf+bounces-47538-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78EC29FA948
	for <lists+bpf@lfdr.de>; Mon, 23 Dec 2024 03:16:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2D5E164B14
	for <lists+bpf@lfdr.de>; Mon, 23 Dec 2024 02:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AF0C3B7A8;
	Mon, 23 Dec 2024 02:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="bn+cKf+6"
X-Original-To: bpf@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C06632;
	Mon, 23 Dec 2024 02:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734920168; cv=none; b=jhnrZ5bFp3J5lOzGpHF0JlJA5+o6dwL8CU2mrnHh4d94tRX3A4cAcvIleNyU9/foccjALN7AhpreROodDqAQ4n0fvOlTsBo/1jAcXp25HseBhLfWFKGkuftJ934XDAZ2aMnIN9+9tf9fhEp7xPx138ewjqp5jb0aVkztBVCfSFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734920168; c=relaxed/simple;
	bh=fYb8/eRsED0a5QPevVYXqFlTk81Xxf99AFlxwor7Bx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RUnI4W1X0wnWmRiHjGQjLeYybXtVJj+ZYkFTkFt2zFskr+VtuRXR3PVcyCh0awz/YDCqO4kN83gdTlnYzeu+GZU5mapQ5/kO1D8T1Ui1oMKys7nBwZa84GBSu+ISYeNEn5jG59wKm8bKGXQkmbraAZDMqSRromxWvHkvGfGNs+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=bn+cKf+6; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1734920161; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=X8L9prpbeK1sda734hduULb78ArRrtxowYpuEuW1bZM=;
	b=bn+cKf+6jWnT90k7Mr6akem1g6VMseS2C7F/L/smAJ6fTPoqWn0qHbpVV1WPRZRBBMLGaAzuNQazGUFKuK5bFlVKukAtu0hXoFQCe7/wq/fzr7+dICUCapIoS5VSqQcHB+DAGLrolI1Q9YjlZpD8ZDJMmq7GTLuw0GBcu226Fuw=
Received: from localhost(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0WM-5smN_1734919836 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 23 Dec 2024 10:10:37 +0800
Date: Mon, 23 Dec 2024 10:10:36 +0800
From: "D. Wythe" <alibuda@linux.alibaba.com    >
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: "D. Wythe" <alibuda@linux.alibaba.com>, kgraul@linux.ibm.com,
	wenjia@linux.ibm.com, jaka@linux.ibm.com, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, pabeni@redhat.com,
	song@kernel.org, sdf@google.com, haoluo@google.com, yhs@fb.com,
	edumazet@google.com, john.fastabend@gmail.com, kpsingh@kernel.org,
	jolsa@kernel.org, guwen@linux.alibaba.com, kuba@kernel.org,
	davem@davemloft.net, netdev@vger.kernel.org,
	linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org,
	bpf@vger.kernel.org, Daniel Xu <dlxu@meta.com>
Subject: Re: [PATCH bpf-next v3 4/5] libbpf: fix error when st-prefix_ops and
 ops from differ btf
Message-ID: <20241223021036.GC36000@j66a10360.sqa.eu95>
References: <20241218024422.23423-1-alibuda@linux.alibaba.com>
 <20241218024422.23423-5-alibuda@linux.alibaba.com>
 <2f56aca3-a27a-49b6-90de-7f1b2ff39df1@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f56aca3-a27a-49b6-90de-7f1b2ff39df1@linux.dev>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Thu, Dec 19, 2024 at 02:43:30PM -0800, Martin KaFai Lau wrote:
> On 12/17/24 6:44 PM, D. Wythe wrote:
> >Here are four possible case:
> >
> >+--------+-------------+-------------+---------------------------------+
> >|        | st_opx_xxx  | xxx         |                                 |
> >+--------+-------------+-------------+---------------------------------+
> >| case 0 | btf_vmlinux | bft_vmlinux | be used and reg only in vmlinux |
> >+--------+-------------+-------------+---------------------------------+
> >| case 1 | btf_vmlinux | bpf_mod     | INVALID                         |
> >+--------+-------------+-------------+---------------------------------+
> >| case 2 | btf_mod     | btf_vmlinux | reg in mod but be used both in  |
> >|        |             |             | vmlinux and mod.                |
> >+--------+-------------+-------------+---------------------------------+
> >| case 3 | btf_mod     | btf_mod     | be used and reg only in mod     |
> >+--------+-------------+-------------+---------------------------------+
> >
> >At present, cases 0, 1, and 3 can be correctly identified, because
> >st_ops_xxx is searched from the same btf with xxx. In order to
> >handle case 2 correctly without affecting other cases, we cannot simply
> >change the search method for st_ops_xxx from find_btf_by_prefix_kind()
> >to find_ksym_btf_id(), because in this way, case 1 will not be
> >recognized anymore.
> >  	snprintf(tname, sizeof(tname), "%.*s",
> >@@ -1020,17 +1021,25 @@ find_struct_ops_kern_types(struct bpf_object *obj, const char *tname_raw,
> >  	}
> >  	kern_type = btf__type_by_id(btf, kern_type_id);
> >+	ret = snprintf(stname, sizeof(stname), "%s%s", STRUCT_OPS_VALUE_PREFIX, tname);
> 
> How about always look for "struct bpf_struct_ops_smc_ops" first,
> figure out the btf, and then look for "struct smc_ops", would it
> work?

I think this might not work, as the core issue lies in the fact that
bpf_struct_ops_smc_ops and smc_ops are located on different btf.
Searching for one fisrt cannot lead to the inference of the other.

> 
> If CONFIG_SMC=y instead of =m, this change cannot be tested?
> 

That is indeed a problem, but currently there is no better solution
unless the CI can add a step to run 'make modules_install'.


Best wishes,
D. Wythe

> >+	if (ret < 0 || ret >= sizeof(stname))
> >+		return -ENAMETOOLONG;
> >+
> >  	/* Find the corresponding "map_value" type that will be used
> >  	 * in map_update(BPF_MAP_TYPE_STRUCT_OPS).  For example,
> >  	 * find "struct bpf_struct_ops_tcp_congestion_ops" from the
> >  	 * btf_vmlinux.
> >  	 */
> >-	kern_vtype_id = find_btf_by_prefix_kind(btf, STRUCT_OPS_VALUE_PREFIX,
> >-						tname, BTF_KIND_STRUCT);
> >+	kern_vtype_id = btf__find_by_name_kind(btf, stname, BTF_KIND_STRUCT);
> >  	if (kern_vtype_id < 0) {
> >-		pr_warn("struct_ops init_kern: struct %s%s is not found in kernel BTF\n",
> >-			STRUCT_OPS_VALUE_PREFIX, tname);
> >-		return kern_vtype_id;
> >+		if (kern_vtype_id == -ENOENT && !*mod_btf)
> >+			kern_vtype_id = find_ksym_btf_id(obj, stname, BTF_KIND_STRUCT,
> >+							 &btf, mod_btf);
> >+		if (kern_vtype_id < 0) {
> >+			pr_warn("struct_ops init_kern: struct %s is not found in kernel BTF\n",
> >+				stname);
> >+			return kern_vtype_id;
> >+		}
> >  	}
> >  	kern_vtype = btf__type_by_id(btf, kern_vtype_id);
> >@@ -1046,8 +1055,8 @@ find_struct_ops_kern_types(struct bpf_object *obj, const char *tname_raw,
> >  			break;
> >  	}
> >  	if (i == btf_vlen(kern_vtype)) {
> >-		pr_warn("struct_ops init_kern: struct %s data is not found in struct %s%s\n",
> >-			tname, STRUCT_OPS_VALUE_PREFIX, tname);
> >+		pr_warn("struct_ops init_kern: struct %s data is not found in struct %s\n",
> >+			tname, stname);
> >  		return -EINVAL;
> >  	}

