Return-Path: <bpf+bounces-57858-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9DAEAB188B
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 17:33:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8165E3B8148
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 15:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3582422F76A;
	Fri,  9 May 2025 15:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NRRWNxM1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D139B22DFAD;
	Fri,  9 May 2025 15:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746804651; cv=none; b=b0WackYWhHthO0R06x008eOFz3KfdzF4sIbNfRWtxd+VZKntFvMK0OMbc7xBIHzA7cGS5F6hTh/qiZcyC+CGL0VEh4DGN7vxgGybuVmUHzDWrrE1kaPxtEXV3r/32S6HLO/a7YEQAhs47Pjgcpeq8aaYlqy4/nwChzhGVdl2mP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746804651; c=relaxed/simple;
	bh=FlsGd0H2ZSTNWVLyuJJUnWQ1M3x2sOWkpxCwAhT5tnM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dNkVRJlmQHVFYJ6gGjKHp9Hdwq/zSoWoej4BWc/1KF06Pfy94Tuh3OCvZ5EyR/QcW0atcRIzKEfclf7aqaG0BlHZ+DgRhVT2QX3oYfmskKSDJXQHR46wvR1HECdpNKxYX3qKQwwe2O7Yr3XZ1yTbEzv+oWRmortxm04Bhc2aUeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NRRWNxM1; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ac289147833so444265066b.2;
        Fri, 09 May 2025 08:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746804648; x=1747409448; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4CSJ52xkRueggeNTm2zsnktuWXB/I+efI1BiSHUzwtM=;
        b=NRRWNxM1FcrZVMLKewqAla2W6kJmm4SRRo7yRNASDzuETsgT4ERwIvPlcfYG3aWqCM
         LhtL2w/O0rBJl8el5VSWzn2/lijIFpplWi3wcyCAn68ykB8Wj91yDOQbXav3xUF1pnGI
         teGvGZuRVloHUkhhHvuW2cN3ZMhAdFwafyzujVBbkqGydHHapuFOviR5mzDxNk6ap9//
         HVC8SDYOImzC9E7feCOKS9ou2TpXCQsc1OTP+dYhr0IJVkHw3RrUyuP8KtxFLRtSrh1J
         GIxOCh7be9JUkkbMSUVe8ys44pL2qGrajk8oMD/r3UTayi205VgJD+CfNsrNdgmyfhrb
         DkGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746804648; x=1747409448;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4CSJ52xkRueggeNTm2zsnktuWXB/I+efI1BiSHUzwtM=;
        b=FwuURCGFNblugiJwiUky9Iw6Cv9CmyIh0PS77pXznTeIWvixd0FAON7wvhBx+cF/1o
         Lntm0V+3vXx4iwy2j35WCQl+ZxuYvv/qp6+juK74N3MnH6ZM/e0oT9/NbC/0PLRfnR5m
         QCgKHZZTI6Q8w8TqRoP4VmP0Vu5hwOXdrkBs55SWfBu1FMS2vm1l/NQCu+fSlrFiQRy1
         kBdggwtkuT9be4AWcBJdzvvs1JJFnEeD4CnCCFS4fPUpg2WMxYeEN2wEJvd78aeGtM2w
         H2btl3plpwidSxL9gZtwXp7fA5guuNAadKIX1vtLKbFJfD8yukxGXS92Nh61i9UEFEch
         NXcQ==
X-Forwarded-Encrypted: i=1; AJvYcCXaleDRvicJw3/JEv42Td+Ke58Bxx0uAJPK8O63esgghjDEjpKgy3oF7UzXlmGWxQMQFR4=@vger.kernel.org, AJvYcCXiEob1/BRh+sw+ac47ekRnMg3HOQ/ouTd2kW92ofj72klt9ewf033EuSsOG0MUmxSK9QZl0f3+HjObVlg4sj79Jw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyKsRKmrAzgItoTJyHgi03ii1URxkbH73i4kVn+OPwk8B5eG2CF
	9of72CZEU1FFITTRi1DEMVqjcwgrS7jCR/sHN6tz4SAt7oDaQqHA
X-Gm-Gg: ASbGncuVghsJpGBRBOT1mpnV/16Lnh/uIvSriZ0VrH/vDMll90A6wAXmbV07XqIuvpR
	dQDoZh4vkYvzoW/lmfvkI+EqQVD/pT9AUJNe/pW60krDRiuWlcQOSesOYTBBKE4bPyJUyL04OUX
	q0brpOQeTtfd+1QGMCUnF305ok78O+qiPcwuXz9kLe5BWfjd6yPGVrZTJ9HCxtQY84ea19zZmoh
	gd1XYrPCnCC6LGKtrNfsJkKYVg2auL9bcSv7D6z6WEj5A8MxBOFN2REO3HNVGqJMI1gDUmMTGct
	1jq/29itn/er26RfgAzTtZhEkhOoL9xxNw==
X-Google-Smtp-Source: AGHT+IFfABcpw52bl2Hyw72KBKQkqIhRH6x+MgfWbgRotqbi3vDtUqkC2GUY5M/7N3MQkyKTPd7ENg==
X-Received: by 2002:a17:906:4796:b0:ac3:3d10:6f with SMTP id a640c23a62f3a-ad218e52dd4mr364996366b.8.1746804647790;
        Fri, 09 May 2025 08:30:47 -0700 (PDT)
Received: from krava ([2a00:102a:5026:d3d1:a9d5:aaa4:3efe:38c7])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad2197bd364sm163994866b.133.2025.05.09.08.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 08:30:47 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 9 May 2025 17:30:44 +0200
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-perf-users@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Yafang Shao <laoar.shao@gmail.com>,
	Quentin Monnet <qmo@kernel.org>
Subject: Re: [PATCH bpf-next 3/3] bpftool: Display ref_ctr_offset for uprobe
 link info
Message-ID: <aB4fpAlfNhshy5DA@krava>
References: <20250506135727.3977467-1-jolsa@kernel.org>
 <20250506135727.3977467-4-jolsa@kernel.org>
 <CAEf4Bzbpn8kQV8ORoBv7iDR1VxT0uUf=qqjanFQFtFx1fSjrQQ@mail.gmail.com>
 <aBsgQw1kzJsRzM5p@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aBsgQw1kzJsRzM5p@krava>

On Wed, May 07, 2025 at 10:56:35AM +0200, Jiri Olsa wrote:
> On Tue, May 06, 2025 at 03:33:33PM -0700, Andrii Nakryiko wrote:
> > On Tue, May 6, 2025 at 6:58 AM Jiri Olsa <jolsa@kernel.org> wrote:
> > >
> > > Adding support to display ref_ctr_offset in link output, like:
> > >
> > >   # bpftool link
> > >   ...
> > >   42: perf_event  prog 174
> > >           uprobe /proc/self/exe+0x102f13  cookie 3735928559  ref_ctr_offset 50500538
> > 
> > let's use hex for ref_ctr_offset?
> 
> I had that, then I saw cookie was dec ;-) either way is fine for me
> 
> > 
> > and also, why do we have bpf_cookie and cookie emitted? Are they different?
> 
> hum, right.. so there's bpf_cookie retrieval from perf_link through the
> task_file iterator:
> 
>   cbdaf71f7e65 bpftool: Add bpf_cookie to link output
> 
> I guess it was added before we decided to have bpf_link_info.perf_event
> interface, which seems easier to me

we could drop the bpf_cookie with attached patch, but should we worry
about loosing 'bpf_cookie' tag from json output (there will be just
'cookie' tag now with the same value)

jirka


---
diff --git a/tools/bpf/bpftool/main.h b/tools/bpf/bpftool/main.h
index 9eb764fe4cc8..ca8923425637 100644
--- a/tools/bpf/bpftool/main.h
+++ b/tools/bpf/bpftool/main.h
@@ -104,9 +104,7 @@ struct obj_ref {
 
 struct obj_refs {
 	int ref_cnt;
-	bool has_bpf_cookie;
 	struct obj_ref *refs;
-	__u64 bpf_cookie;
 };
 
 struct btf;
diff --git a/tools/bpf/bpftool/pids.c b/tools/bpf/bpftool/pids.c
index 23f488cf1740..e81518dfc835 100644
--- a/tools/bpf/bpftool/pids.c
+++ b/tools/bpf/bpftool/pids.c
@@ -80,8 +80,6 @@ static void add_ref(struct hashmap *map, struct pid_iter_entry *e)
 	memcpy(ref->comm, e->comm, sizeof(ref->comm));
 	ref->comm[sizeof(ref->comm) - 1] = '\0';
 	refs->ref_cnt = 1;
-	refs->has_bpf_cookie = e->has_bpf_cookie;
-	refs->bpf_cookie = e->bpf_cookie;
 
 	err = hashmap__append(map, e->id, refs);
 	if (err)
@@ -214,9 +212,6 @@ void emit_obj_refs_json(struct hashmap *map, __u32 id,
 		if (refs->ref_cnt == 0)
 			break;
 
-		if (refs->has_bpf_cookie)
-			jsonw_lluint_field(json_writer, "bpf_cookie", refs->bpf_cookie);
-
 		jsonw_name(json_writer, "pids");
 		jsonw_start_array(json_writer);
 		for (i = 0; i < refs->ref_cnt; i++) {
@@ -246,9 +241,6 @@ void emit_obj_refs_plain(struct hashmap *map, __u32 id, const char *prefix)
 		if (refs->ref_cnt == 0)
 			break;
 
-		if (refs->has_bpf_cookie)
-			printf("\n\tbpf_cookie %llu", (unsigned long long) refs->bpf_cookie);
-
 		printf("%s", prefix);
 		for (i = 0; i < refs->ref_cnt; i++) {
 			struct obj_ref *ref = &refs->refs[i];
diff --git a/tools/bpf/bpftool/skeleton/pid_iter.bpf.c b/tools/bpf/bpftool/skeleton/pid_iter.bpf.c
index 948dde25034e..ea6d54f43425 100644
--- a/tools/bpf/bpftool/skeleton/pid_iter.bpf.c
+++ b/tools/bpf/bpftool/skeleton/pid_iter.bpf.c
@@ -15,19 +15,6 @@ enum bpf_obj_type {
 	BPF_OBJ_BTF,
 };
 
-struct bpf_perf_link___local {
-	struct bpf_link link;
-	struct file *perf_file;
-} __attribute__((preserve_access_index));
-
-struct perf_event___local {
-	u64 bpf_cookie;
-} __attribute__((preserve_access_index));
-
-enum bpf_link_type___local {
-	BPF_LINK_TYPE_PERF_EVENT___local = 7,
-};
-
 extern const void bpf_link_fops __ksym;
 extern const void bpf_link_fops_poll __ksym __weak;
 extern const void bpf_map_fops __ksym;
@@ -52,17 +39,6 @@ static __always_inline __u32 get_obj_id(void *ent, enum bpf_obj_type type)
 	}
 }
 
-/* could be used only with BPF_LINK_TYPE_PERF_EVENT links */
-static __u64 get_bpf_cookie(struct bpf_link *link)
-{
-	struct bpf_perf_link___local *perf_link;
-	struct perf_event___local *event;
-
-	perf_link = container_of(link, struct bpf_perf_link___local, link);
-	event = BPF_CORE_READ(perf_link, perf_file, private_data);
-	return BPF_CORE_READ(event, bpf_cookie);
-}
-
 SEC("iter/task_file")
 int iter(struct bpf_iter__task_file *ctx)
 {
@@ -102,18 +78,6 @@ int iter(struct bpf_iter__task_file *ctx)
 	e.pid = task->tgid;
 	e.id = get_obj_id(file->private_data, obj_type);
 
-	if (obj_type == BPF_OBJ_LINK &&
-	    bpf_core_enum_value_exists(enum bpf_link_type___local,
-				       BPF_LINK_TYPE_PERF_EVENT___local)) {
-		struct bpf_link *link = (struct bpf_link *) file->private_data;
-
-		if (BPF_CORE_READ(link, type) == bpf_core_enum_value(enum bpf_link_type___local,
-								     BPF_LINK_TYPE_PERF_EVENT___local)) {
-			e.has_bpf_cookie = true;
-			e.bpf_cookie = get_bpf_cookie(link);
-		}
-	}
-
 	bpf_probe_read_kernel_str(&e.comm, sizeof(e.comm),
 				  task->group_leader->comm);
 	bpf_seq_write(ctx->meta->seq, &e, sizeof(e));
diff --git a/tools/bpf/bpftool/skeleton/pid_iter.h b/tools/bpf/bpftool/skeleton/pid_iter.h
index bbb570d4cca6..5692cf257adb 100644
--- a/tools/bpf/bpftool/skeleton/pid_iter.h
+++ b/tools/bpf/bpftool/skeleton/pid_iter.h
@@ -6,8 +6,6 @@
 struct pid_iter_entry {
 	__u32 id;
 	int pid;
-	__u64 bpf_cookie;
-	bool has_bpf_cookie;
 	char comm[16];
 };
 

