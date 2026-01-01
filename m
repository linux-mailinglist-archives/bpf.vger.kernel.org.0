Return-Path: <bpf+bounces-77663-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B2B6CED0E9
	for <lists+bpf@lfdr.de>; Thu, 01 Jan 2026 14:53:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C121730062E2
	for <lists+bpf@lfdr.de>; Thu,  1 Jan 2026 13:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB192245019;
	Thu,  1 Jan 2026 13:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZRsY4x4T"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4CE1D5CD9
	for <bpf@vger.kernel.org>; Thu,  1 Jan 2026 13:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767275572; cv=none; b=QVGcOfOelmrjiBfpdR8BC5CXoPeFpdo0XnlpnNWesguDXigVKMA6cn9+t2uYmeDZrelxDfEkHlXEPVJBQzIOvimLlWkw8WbWYYvHM+adcXtrntcyXAyLlhmvyanxuzmeFfLWOJICoUb0PqeZG2/vzc467LTu/b18iiYjaxPCVfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767275572; c=relaxed/simple;
	bh=JngaPYe7celccn/40A8xDQJiVt9wmDUffXA+IHmojRA=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JugzZQo3rD32TH1TuLogGY2ueX9UQg2Zy7hWAYjqM5XikKEmI18EaQqhVzgRCVitnubhAUcqmT1V5c9hnapGLn6TdQLH2ezUZASBP+Hq2SBlVXL2foGO1epwippZ9SDjwvJArzsHp5fmU3PNhbYGGWdZGvRiWWMrruoJExmJVA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZRsY4x4T; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-47d1d8a49f5so55302785e9.3
        for <bpf@vger.kernel.org>; Thu, 01 Jan 2026 05:52:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767275569; x=1767880369; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2oYFP1afTViiWa0k3ptFFA82/ht3QtAavgSwTUsgiuE=;
        b=ZRsY4x4TP9qEAU5WPjQZ4QX+bf7X64kq4nOK6hROS8kQpI245bfE8ziq4RqcJh33Nz
         4hsZR6tAUiXmmDwSBuxPY9LKkg6Ha08nvlQDvb67xxKaL5EhUNSyS8pHTS649oAyUJYu
         HvzmKrH45ouCZG2CuM8oaSS5A4SB3oxPO13k1QVkWdiYgkuFJFcqBEp5hE59YXF8gg8K
         4ZSMto6SC13Wf060H7Knprnb+SFUIgeJBtQaB68CxbTUQ1AwKkBroWLBnhzmjUOAvR7M
         /46W7641jMMDx82q0Osr1y0WbQJgqoiIiWyOwoNyHIpykYwnMZ1j440AArcy3/4yHmla
         svmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767275569; x=1767880369;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2oYFP1afTViiWa0k3ptFFA82/ht3QtAavgSwTUsgiuE=;
        b=ne7YCoftMQvjiC22sc10q6xwKyoaEb8fUPQHvNomXbqSaFyDxNHWCLstnXwj9IJwBg
         UCimpsP4yNt43j6iWHdQDwivkHjoEgiAOsEPrTy6nRTS6y7O0ECaueWzhDZBq7fo4hnv
         qEtrsL7fGNX9rnI9bXaz+StB84z+uNbSSRMoCkFMxcNqv939pK+y1eTOlq4QckBrsIvF
         DAVSv1Um6nDBRzkJ035f7LS6LDbii0Y7QAv8eV6m2/seyYC8BCsXKu0k5DFJUNAXpbtJ
         piPtyo6ygyaikYGfq2nAAoWU09/GTYx+PpK3DcwWRpPDaWA9y2nxR02cJ1bEitgGxbAC
         JbZw==
X-Forwarded-Encrypted: i=1; AJvYcCWOEpzJQ7+WvbM2HujWGedBHVD6kX0sAb3mOA4FKV1ra+lpMAR3mjM4g3Usf8f2+6J/BXI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9Lq4FeuEGSwwGmpDvHgBSffCw/OKjib2SsUGCsAahV97AlW+U
	9D25q3iCdXbUCzGGQqsKQ4qg12PmKUG9Prix0E0RKONkUtWkzEMk0k+q
X-Gm-Gg: AY/fxX74qiv+BHY04Igb7oJXBrG0BYPz5M45g5quSD+v8rpYGxt3R1ujgoKWUPFZd+7
	9g/2VorcNokhbto1+6OdE6Kbjz7e/2SXfZwxc6xvEfXEQ5FIFXG6ju+GBfoEv5jKFC+2Ov5RUaN
	0FGcVgn8DABMiXxda0Zjc9VOljRYwwMyIOIUAqV0Z/qaDKWKgd52Nt3SJImgVr6Aq3cNRY75p+L
	tXatBJmu6Bil0kribe+pDZEKXUgmgxNxxyrKCXmbPjVDyuoLrcDZ0qzjCdcakke5dxETA4DAElt
	lYW5w+7pSAJXWZyXNHTUQJbYdK9lW32g3In32cl3iUT2Ab0wrdRYUsJb6oNbzpTMM3johiIFgaO
	en5v35T6QmP/EQ3OdUcFd0y1c4c+gEhM6b19CCnqQ/vm4QyFV5wUPBRtWPnK8ChpeiuOntzQRQ7
	8=
X-Google-Smtp-Source: AGHT+IE18iFYdMkxEuQfkDsYO2vpFgVpa0RSiS17WBdiZ262JJkrQExdId1oUtX/8/bA9uZmQY7z2A==
X-Received: by 2002:a05:600c:3486:b0:471:700:f281 with SMTP id 5b1f17b1804b1-47d1958f974mr475655875e9.25.1767275568358;
        Thu, 01 Jan 2026 05:52:48 -0800 (PST)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be3ac4c1esm293096855e9.14.2026.01.01.05.52.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jan 2026 05:52:47 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 1 Jan 2026 14:52:45 +0100
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
	yonghong.song@linux.dev, john.fastabend@gmail.com,
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
	davem@davemloft.net, dsahern@kernel.org, tglx@linutronix.de,
	mingo@redhat.com, jiang.biao@linux.dev, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	bpf@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v5 01/10] bpf: add fsession support
Message-ID: <aVZ8LQXPhRqUz5dO@krava>
References: <20251224130735.201422-1-dongml2@chinatelecom.cn>
 <20251224130735.201422-2-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251224130735.201422-2-dongml2@chinatelecom.cn>

On Wed, Dec 24, 2025 at 09:07:26PM +0800, Menglong Dong wrote:

SNIP

> +struct bpf_fsession_link {
> +	struct bpf_tracing_link link;
> +	struct bpf_tramp_link fexit;
> +};
> +
>  struct bpf_raw_tp_link {
>  	struct bpf_link link;
>  	struct bpf_raw_event_map *btp;
> @@ -2114,6 +2120,20 @@ static inline void bpf_struct_ops_desc_release(struct bpf_struct_ops_desc *st_op
>  
>  #endif
>  
> +static inline int bpf_fsession_cnt(struct bpf_tramp_links *links)
> +{
> +	struct bpf_tramp_links fentries = links[BPF_TRAMP_FENTRY];
> +	int cnt = 0;
> +
> +	for (int i = 0; i < links[BPF_TRAMP_FENTRY].nr_links; i++) {
> +		if (fentries.links[i]->link.prog->expected_attach_type ==
> +		    BPF_TRACE_FSESSION)

let's keep it on the single line ?

> +			cnt++;
> +	}
> +
> +	return cnt;
> +}
> +
>  int bpf_prog_ctx_arg_info_init(struct bpf_prog *prog,
>  			       const struct bpf_ctx_arg_aux *info, u32 cnt);
>  
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 84ced3ed2d21..cd2d7c4fc6e7 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -1145,6 +1145,7 @@ enum bpf_attach_type {
>  	BPF_NETKIT_PEER,
>  	BPF_TRACE_KPROBE_SESSION,
>  	BPF_TRACE_UPROBE_SESSION,
> +	BPF_TRACE_FSESSION,
>  	__MAX_BPF_ATTACH_TYPE
>  };
>  
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 0de8fc8a0e0b..dff3eae4b51e 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -6107,6 +6107,7 @@ static int btf_validate_prog_ctx_type(struct bpf_verifier_log *log, const struct
>  		case BPF_TRACE_FENTRY:
>  		case BPF_TRACE_FEXIT:
>  		case BPF_MODIFY_RETURN:
> +		case BPF_TRACE_FSESSION:
>  			/* allow u64* as ctx */
>  			if (btf_is_int(t) && t->size == 8)
>  				return 0;
> @@ -6704,6 +6705,7 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
>  			fallthrough;
>  		case BPF_LSM_CGROUP:
>  		case BPF_TRACE_FEXIT:
> +		case BPF_TRACE_FSESSION:
>  			/* When LSM programs are attached to void LSM hooks
>  			 * they use FEXIT trampolines and when attached to
>  			 * int LSM hooks, they use MODIFY_RETURN trampolines.
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 3080cc48bfc3..3bfaf550ad08 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -3579,6 +3579,7 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
>  	case BPF_PROG_TYPE_TRACING:
>  		if (prog->expected_attach_type != BPF_TRACE_FENTRY &&
>  		    prog->expected_attach_type != BPF_TRACE_FEXIT &&
> +		    prog->expected_attach_type != BPF_TRACE_FSESSION &&
>  		    prog->expected_attach_type != BPF_MODIFY_RETURN) {
>  			err = -EINVAL;
>  			goto out_put_prog;
> @@ -3628,7 +3629,21 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
>  		key = bpf_trampoline_compute_key(tgt_prog, NULL, btf_id);
>  	}
>  
> -	link = kzalloc(sizeof(*link), GFP_USER);
> +	if (prog->expected_attach_type == BPF_TRACE_FSESSION) {
> +		struct bpf_fsession_link *fslink;
> +
> +		fslink = kzalloc(sizeof(*fslink), GFP_USER);
> +		if (fslink) {
> +			bpf_link_init(&fslink->fexit.link, BPF_LINK_TYPE_TRACING,
> +				      &bpf_tracing_link_lops, prog, attach_type);

I don't think we need the extra exit struct bpf_link, we just need
hlist_node hook for exit program, so this should perhaps be:

struct bpf_fsession_link {
	struct bpf_tracing_link link;
	struct hlist_node tramp_hlist;
};


SNIP

> @@ -596,6 +598,8 @@ static int __bpf_trampoline_link_prog(struct bpf_tramp_link *link,
>  {
>  	enum bpf_tramp_prog_type kind;
>  	struct bpf_tramp_link *link_exiting;
> +	struct bpf_fsession_link *fslink;
> +	struct hlist_head *prog_list;
>  	int err = 0;
>  	int cnt = 0, i;
>  
> @@ -621,24 +625,44 @@ static int __bpf_trampoline_link_prog(struct bpf_tramp_link *link,
>  					  BPF_MOD_JUMP, NULL,
>  					  link->link.prog->bpf_func);
>  	}
> +	if (kind == BPF_TRAMP_FSESSION) {
> +		prog_list = &tr->progs_hlist[BPF_TRAMP_FENTRY];
> +		cnt++;
> +	} else {
> +		prog_list = &tr->progs_hlist[kind];
> +	}
>  	if (cnt >= BPF_MAX_TRAMP_LINKS)
>  		return -E2BIG;
>  	if (!hlist_unhashed(&link->tramp_hlist))
>  		/* prog already linked */
>  		return -EBUSY;
> -	hlist_for_each_entry(link_exiting, &tr->progs_hlist[kind], tramp_hlist) {
> +	hlist_for_each_entry(link_exiting, prog_list, tramp_hlist) {
>  		if (link_exiting->link.prog != link->link.prog)
>  			continue;
>  		/* prog already linked */
>  		return -EBUSY;
>  	}
>  
> -	hlist_add_head(&link->tramp_hlist, &tr->progs_hlist[kind]);
> -	tr->progs_cnt[kind]++;
> +	hlist_add_head(&link->tramp_hlist, prog_list);
> +	if (kind == BPF_TRAMP_FSESSION) {
> +		tr->progs_cnt[BPF_TRAMP_FENTRY]++;
> +		fslink = container_of(link, struct bpf_fsession_link, link.link);
> +		hlist_add_head(&fslink->fexit.tramp_hlist,
> +			       &tr->progs_hlist[BPF_TRAMP_FEXIT]);
> +		tr->progs_cnt[BPF_TRAMP_FEXIT]++;
> +	} else {
> +		tr->progs_cnt[kind]++;
> +	}
>  	err = bpf_trampoline_update(tr, true /* lock_direct_mutex */);
>  	if (err) {
>  		hlist_del_init(&link->tramp_hlist);
> -		tr->progs_cnt[kind]--;
> +		if (kind == BPF_TRAMP_FSESSION) {
> +			tr->progs_cnt[BPF_TRAMP_FENTRY]--;
> +			hlist_del_init(&fslink->fexit.tramp_hlist);
> +			tr->progs_cnt[BPF_TRAMP_FEXIT]--;
> +		} else {
> +			tr->progs_cnt[kind]--;
> +		}
>  	}
>  	return err;

this seems confusing, how about we just add abolish bpf_fsession_link
and add extra hlist_node hook to struct bpf_tramp_link .. we will waste
16 bytes for other cases, but the code seems less confusing to me

untested, so I might overlooked something..

jirka



---
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 4e7d72dfbcd4..7479664844ea 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1309,6 +1309,7 @@ enum bpf_tramp_prog_type {
 	BPF_TRAMP_MODIFY_RETURN,
 	BPF_TRAMP_MAX,
 	BPF_TRAMP_REPLACE, /* more than MAX */
+	BPF_TRAMP_FSESSION,
 };
 
 struct bpf_tramp_image {
@@ -1861,6 +1862,7 @@ struct bpf_link_ops {
 struct bpf_tramp_link {
 	struct bpf_link link;
 	struct hlist_node tramp_hlist;
+	struct hlist_node extra_hlist;
 	u64 cookie;
 };
 
@@ -2169,6 +2171,19 @@ static inline void bpf_struct_ops_desc_release(struct bpf_struct_ops_desc *st_op
 
 #endif
 
+static inline int bpf_fsession_cnt(struct bpf_tramp_links *links)
+{
+	struct bpf_tramp_links fentries = links[BPF_TRAMP_FENTRY];
+	int cnt = 0;
+
+	for (int i = 0; i < links[BPF_TRAMP_FENTRY].nr_links; i++) {
+		if (fentries.links[i]->link.prog->expected_attach_type == BPF_TRACE_FSESSION)
+			cnt++;
+	}
+
+	return cnt;
+}
+
 int bpf_prog_ctx_arg_info_init(struct bpf_prog *prog,
 			       const struct bpf_ctx_arg_aux *info, u32 cnt);
 
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 84ced3ed2d21..cd2d7c4fc6e7 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1145,6 +1145,7 @@ enum bpf_attach_type {
 	BPF_NETKIT_PEER,
 	BPF_TRACE_KPROBE_SESSION,
 	BPF_TRACE_UPROBE_SESSION,
+	BPF_TRACE_FSESSION,
 	__MAX_BPF_ATTACH_TYPE
 };
 
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 539c9fdea41d..8b1dcd440356 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6107,6 +6107,7 @@ static int btf_validate_prog_ctx_type(struct bpf_verifier_log *log, const struct
 		case BPF_TRACE_FENTRY:
 		case BPF_TRACE_FEXIT:
 		case BPF_MODIFY_RETURN:
+		case BPF_TRACE_FSESSION:
 			/* allow u64* as ctx */
 			if (btf_is_int(t) && t->size == 8)
 				return 0;
@@ -6704,6 +6705,7 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 			fallthrough;
 		case BPF_LSM_CGROUP:
 		case BPF_TRACE_FEXIT:
+		case BPF_TRACE_FSESSION:
 			/* When LSM programs are attached to void LSM hooks
 			 * they use FEXIT trampolines and when attached to
 			 * int LSM hooks, they use MODIFY_RETURN trampolines.
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index a4d38272d8bc..d05f59bffa02 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3579,6 +3579,7 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
 	case BPF_PROG_TYPE_TRACING:
 		if (prog->expected_attach_type != BPF_TRACE_FENTRY &&
 		    prog->expected_attach_type != BPF_TRACE_FEXIT &&
+		    prog->expected_attach_type != BPF_TRACE_FSESSION &&
 		    prog->expected_attach_type != BPF_MODIFY_RETURN) {
 			err = -EINVAL;
 			goto out_put_prog;
@@ -4352,6 +4353,7 @@ attach_type_to_prog_type(enum bpf_attach_type attach_type)
 	case BPF_TRACE_RAW_TP:
 	case BPF_TRACE_FENTRY:
 	case BPF_TRACE_FEXIT:
+	case BPF_TRACE_FSESSION:
 	case BPF_MODIFY_RETURN:
 		return BPF_PROG_TYPE_TRACING;
 	case BPF_LSM_MAC:
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index 2a125d063e62..f27ed8b934f9 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -111,7 +111,7 @@ bool bpf_prog_has_trampoline(const struct bpf_prog *prog)
 
 	return (ptype == BPF_PROG_TYPE_TRACING &&
 		(eatype == BPF_TRACE_FENTRY || eatype == BPF_TRACE_FEXIT ||
-		 eatype == BPF_MODIFY_RETURN)) ||
+		 eatype == BPF_MODIFY_RETURN || eatype == BPF_TRACE_FSESSION)) ||
 		(ptype == BPF_PROG_TYPE_LSM && eatype == BPF_LSM_MAC);
 }
 
@@ -559,6 +559,8 @@ static enum bpf_tramp_prog_type bpf_attach_type_to_tramp(struct bpf_prog *prog)
 		return BPF_TRAMP_MODIFY_RETURN;
 	case BPF_TRACE_FEXIT:
 		return BPF_TRAMP_FEXIT;
+	case BPF_TRACE_FSESSION:
+		return BPF_TRAMP_FSESSION;
 	case BPF_LSM_MAC:
 		if (!prog->aux->attach_func_proto->type)
 			/* The function returns void, we cannot modify its
@@ -621,6 +623,8 @@ static int __bpf_trampoline_link_prog(struct bpf_tramp_link *link,
 					  BPF_MOD_JUMP, NULL,
 					  link->link.prog->bpf_func);
 	}
+	if (kind == BPF_TRAMP_FSESSION)
+		cnt++;
 	if (cnt >= BPF_MAX_TRAMP_LINKS)
 		return -E2BIG;
 	if (!hlist_unhashed(&link->tramp_hlist))
@@ -633,12 +637,27 @@ static int __bpf_trampoline_link_prog(struct bpf_tramp_link *link,
 		return -EBUSY;
 	}
 
-	hlist_add_head(&link->tramp_hlist, &tr->progs_hlist[kind]);
-	tr->progs_cnt[kind]++;
+	if (kind == BPF_TRAMP_FSESSION) {
+		hlist_add_head(&link->tramp_hlist, &tr->progs_hlist[BPF_TRAMP_FENTRY]);
+		hlist_add_head(&link->extra_hlist, &tr->progs_hlist[BPF_TRAMP_FEXIT]);
+		tr->progs_cnt[BPF_TRAMP_FENTRY]++;
+		tr->progs_cnt[BPF_TRAMP_FEXIT]++;
+	} else {
+		hlist_add_head(&link->tramp_hlist, &tr->progs_hlist[kind]);
+		tr->progs_cnt[kind]++;
+	}
+
 	err = bpf_trampoline_update(tr, true /* lock_direct_mutex */);
 	if (err) {
-		hlist_del_init(&link->tramp_hlist);
-		tr->progs_cnt[kind]--;
+		if (kind == BPF_TRAMP_FSESSION) {
+			hlist_del_init(&link->tramp_hlist);
+			hlist_del_init(&link->extra_hlist);
+			tr->progs_cnt[BPF_TRAMP_FENTRY]--;
+			tr->progs_cnt[BPF_TRAMP_FEXIT]--;
+		} else {
+			hlist_del_init(&link->tramp_hlist);
+			tr->progs_cnt[kind]--;
+		}
 	}
 	return err;
 }
@@ -672,9 +691,15 @@ static int __bpf_trampoline_unlink_prog(struct bpf_tramp_link *link,
 		guard(mutex)(&tgt_prog->aux->ext_mutex);
 		tgt_prog->aux->is_extended = false;
 		return err;
+	} else if (kind == BPF_TRAMP_FSESSION) {
+		hlist_del_init(&link->tramp_hlist);
+		hlist_del_init(&link->extra_hlist);
+		tr->progs_cnt[BPF_TRAMP_FENTRY]--;
+		tr->progs_cnt[BPF_TRAMP_FEXIT]--;
+	} else {
+		hlist_del_init(&link->tramp_hlist);
+		tr->progs_cnt[kind]--;
 	}
-	hlist_del_init(&link->tramp_hlist);
-	tr->progs_cnt[kind]--;
 	return bpf_trampoline_update(tr, true /* lock_direct_mutex */);
 }
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 2de1a736ef69..6146f63cb03a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -17406,6 +17406,7 @@ static int check_return_code(struct bpf_verifier_env *env, int regno, const char
 		switch (env->prog->expected_attach_type) {
 		case BPF_TRACE_FENTRY:
 		case BPF_TRACE_FEXIT:
+		case BPF_TRACE_FSESSION:
 			range = retval_range(0, 0);
 			break;
 		case BPF_TRACE_RAW_TP:
@@ -23303,6 +23304,7 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 		if (prog_type == BPF_PROG_TYPE_TRACING &&
 		    insn->imm == BPF_FUNC_get_func_ret) {
 			if (eatype == BPF_TRACE_FEXIT ||
+			    eatype == BPF_TRACE_FSESSION ||
 			    eatype == BPF_MODIFY_RETURN) {
 				/* Load nr_args from ctx - 8 */
 				insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8);
@@ -24247,7 +24249,8 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 		if (tgt_prog->type == BPF_PROG_TYPE_TRACING &&
 		    prog_extension &&
 		    (tgt_prog->expected_attach_type == BPF_TRACE_FENTRY ||
-		     tgt_prog->expected_attach_type == BPF_TRACE_FEXIT)) {
+		     tgt_prog->expected_attach_type == BPF_TRACE_FEXIT ||
+		     tgt_prog->expected_attach_type == BPF_TRACE_FSESSION)) {
 			/* Program extensions can extend all program types
 			 * except fentry/fexit. The reason is the following.
 			 * The fentry/fexit programs are used for performance
@@ -24262,7 +24265,7 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 			 * beyond reasonable stack size. Hence extending fentry
 			 * is not allowed.
 			 */
-			bpf_log(log, "Cannot extend fentry/fexit\n");
+			bpf_log(log, "Cannot extend fentry/fexit/fsession\n");
 			return -EINVAL;
 		}
 	} else {
@@ -24346,6 +24349,7 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 	case BPF_LSM_CGROUP:
 	case BPF_TRACE_FENTRY:
 	case BPF_TRACE_FEXIT:
+	case BPF_TRACE_FSESSION:
 		if (!btf_type_is_func(t)) {
 			bpf_log(log, "attach_btf_id %u is not a function\n",
 				btf_id);
@@ -24512,6 +24516,7 @@ static bool can_be_sleepable(struct bpf_prog *prog)
 		case BPF_TRACE_FEXIT:
 		case BPF_MODIFY_RETURN:
 		case BPF_TRACE_ITER:
+		case BPF_TRACE_FSESSION:
 			return true;
 		default:
 			return false;
@@ -24593,9 +24598,10 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
 			tgt_info.tgt_name);
 		return -EINVAL;
 	} else if ((prog->expected_attach_type == BPF_TRACE_FEXIT ||
+		   prog->expected_attach_type == BPF_TRACE_FSESSION ||
 		   prog->expected_attach_type == BPF_MODIFY_RETURN) &&
 		   btf_id_set_contains(&noreturn_deny, btf_id)) {
-		verbose(env, "Attaching fexit/fmod_ret to __noreturn function '%s' is rejected.\n",
+		verbose(env, "Attaching fexit/fsession/fmod_ret to __noreturn function '%s' is rejected.\n",
 			tgt_info.tgt_name);
 		return -EINVAL;
 	}
diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 655efac6f133..3b0d9bd039de 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -685,6 +685,7 @@ int bpf_prog_test_run_tracing(struct bpf_prog *prog,
 	switch (prog->expected_attach_type) {
 	case BPF_TRACE_FENTRY:
 	case BPF_TRACE_FEXIT:
+	case BPF_TRACE_FSESSION:
 		if (bpf_fentry_test1(1) != 2 ||
 		    bpf_fentry_test2(2, 3) != 5 ||
 		    bpf_fentry_test3(4, 5, 6) != 15 ||
diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
index 850dd736ccd1..de111818f3a0 100644
--- a/net/core/bpf_sk_storage.c
+++ b/net/core/bpf_sk_storage.c
@@ -365,6 +365,7 @@ static bool bpf_sk_storage_tracing_allowed(const struct bpf_prog *prog)
 		return true;
 	case BPF_TRACE_FENTRY:
 	case BPF_TRACE_FEXIT:
+	case BPF_TRACE_FSESSION:
 		return !!strncmp(prog->aux->attach_func_name, "bpf_sk_storage",
 				 strlen("bpf_sk_storage"));
 	default:
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 6b92b0847ec2..012abaf3d4ac 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1145,6 +1145,7 @@ enum bpf_attach_type {
 	BPF_NETKIT_PEER,
 	BPF_TRACE_KPROBE_SESSION,
 	BPF_TRACE_UPROBE_SESSION,
+	BPF_TRACE_FSESSION,
 	__MAX_BPF_ATTACH_TYPE
 };
 
diff --git a/tools/testing/selftests/bpf/prog_tests/tracing_failure.c b/tools/testing/selftests/bpf/prog_tests/tracing_failure.c
index 10e231965589..f9f9e1cb87bf 100644
--- a/tools/testing/selftests/bpf/prog_tests/tracing_failure.c
+++ b/tools/testing/selftests/bpf/prog_tests/tracing_failure.c
@@ -73,7 +73,7 @@ static void test_tracing_deny(void)
 static void test_fexit_noreturns(void)
 {
 	test_tracing_fail_prog("fexit_noreturns",
-			       "Attaching fexit/fmod_ret to __noreturn function 'do_exit' is rejected.");
+			       "Attaching fexit/fsession/fmod_ret to __noreturn function 'do_exit' is rejected.");
 }
 
 void test_tracing_failure(void)


