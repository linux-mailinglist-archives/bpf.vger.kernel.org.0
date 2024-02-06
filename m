Return-Path: <bpf+bounces-21309-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 557BF84B6C6
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 14:44:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 023B2285453
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 13:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3811113246C;
	Tue,  6 Feb 2024 13:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TxKbkdyN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D243B131E2A;
	Tue,  6 Feb 2024 13:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707226948; cv=none; b=Q5zahtnHRc2gIfRN+BLu8rM7+JD6I0PLNBTTfwvN4gXBnIzKmC0K5CEwtG4yY7yAjTr+MLLvXNCm8RsixApXrkMGKI5h37waP2VKiXEWsMm3oNbVSqG2eQuPR61WvklwPRAtQ/yzFMo5npjpGhLoDAqHL2AY/oUE0tZWxv0+IMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707226948; c=relaxed/simple;
	bh=GlShqf8WT2w2vSpMUrSoQgHJtB1jj0gM1BnNuXyi4TI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q/MBtID38/VOrjf5/kgAsLGFC52TzJAzqm7AqlyoeDYrT5nVznPI3gt5r4QBNwVR0Fr8xqxGY0PxZerQMJfJ+G8jN+pnzMXBK6ZT3ePiEKxWp00TlHc+KAgUAgzpm2Rn+cHCPqtQxZD8Dnurhe77SuZ6Hk3f48pPe7QMN+GswOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TxKbkdyN; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5112d5ab492so7819275e87.0;
        Tue, 06 Feb 2024 05:42:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707226945; x=1707831745; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DvCxEGpp1LBTbMIxGj9uTP+BA8SmI5o1tlv2+r5q8wE=;
        b=TxKbkdyNPra8Ihe0gvDdL+kh0k2mleUhlqDhXDBcBfJLadYCHDyA9E+saGEJI3UesG
         SPBdvirqGRjHMT+exQfaIr8IOX7iDu0cbj0DgnlbNsM1N8uzo/4NGteQCpduV3z8uyMn
         tfbuTXqd5hyDPcJt33/hoKOMmpNA1q0PDvwS9k5TrwCAs2JFpbrux2pQCW5UL3cyeXok
         xhTKYam1Lke2NZlVQkRbDQyNx/Gvd71d/Sz8bmOqs1800UKT8mn2W8n5xEnDCcW+j40L
         zGOqiB/QoWToZ9Qf51PRlD0VSzG4gyKyVLdUVZCkutVra2YYmta6tkfxD4l93wY2u5P3
         sb9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707226945; x=1707831745;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DvCxEGpp1LBTbMIxGj9uTP+BA8SmI5o1tlv2+r5q8wE=;
        b=awqQz89Ty6aKbVp9weWA83MYD1claVc5DBNODbRUM3H/1jAPW7f4FIs1//hpXAEEdB
         OFehAOOdJEy/VXvQ35uyeQf3WndJ/LqDllHzv2JVJDwWSrfjwg7o8BPJZwxihiDkAROK
         mbk8I08mlTWeNUHtzphknOx6b1dpsfa18AC8sJmFf++cCg3cD6kEdM0etH5b2KUhS+sh
         cEySqaDZB73C4VyneX5vJNYVCvbDZ88CvfFIMJUDQscvAN3kcP92/oRKDnEn9v56Vhtc
         IUSyV0IKWn5vuQAvrhzGt/pqkmqtnUQD8sWRL7jBESpMhKs+E84/4RTYVGwys6t/d9Cb
         8z3Q==
X-Gm-Message-State: AOJu0YysGqDQ4G1ZHrZ2kUcr6OYJDRA9cxWe8MlKpnPrWM9Yq1DltlzG
	rOcl2AZnW6I4JPe7sadGoAdMNN506cX9YCPCx/OWDItsVfHYHvxh
X-Google-Smtp-Source: AGHT+IHZwPijrD88mhAIAJC0rMRlAMnOMQwuVJbxp9zp/h8tVDXln0+Hu3ISwCBm8oGNO1i223q33A==
X-Received: by 2002:a05:6512:eaa:b0:511:6241:d43a with SMTP id bi42-20020a0565120eaa00b005116241d43amr135912lfb.10.1707226944527;
        Tue, 06 Feb 2024 05:42:24 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWErrjj1SxBBxi5SsVN/zaR7PznFG8yWEqhFoPf3IgiKkm/Xj3wucGqzI4HTYRthaUHPX1MomlSdQUyHjRm0NaAgQSip4GnZh4C0EyXmxY+gpEI1gTKkYyQGhJrKaODrEY692Dx1uCVWo9Te2FZFULK5EvR3gT20RE4Muk6BFCQ074dSpUqajHKM+aoNKvlIQLLnvYeLSqryjNlNhiO6XLk4u73LSameoxL/oK6B71038SYzBtED0/pgYFSQ524eKCON2OODfOH/MVPYWvIUTVY2iZmXf6wjPZdew0sI1F2xFJhISEzF1/eIwcHtwBB8XGe3+8K1V0Kkoz5Daw65gqwuQIFAEpsjN6p8aN4KEXxfPgIafupfer2hXigdua3rQD2XaPZ8nTawMdEkvZR6v6id3Xgw+qW7xHSjxYslWeqKUL55NzS5HRLGcfhk5NyttcM5KKP7uTMGvIun45Ky0+RN+NvYWG1Kfbu7uZPjE8S
Received: from krava ([144.178.231.99])
        by smtp.gmail.com with ESMTPSA id qh22-20020a170906ecb600b00a37319aada3sm1152753ejb.153.2024.02.06.05.42.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 05:42:23 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 6 Feb 2024 14:42:22 +0100
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: andrii@kernel.org, daniel@iogearbox.net, ast@kernel.org,
	olsajiri@gmail.com, quentin@isovalent.com, alan.maguire@oracle.com,
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
	yonghong.song@linux.dev, john.fastabend@gmail.com,
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Have bpf_rdonly_cast() take a const
 pointer
Message-ID: <ZcI3Pt6Gr45wiig7@krava>
References: <cover.1707080349.git.dxu@dxuuu.xyz>
 <dfd3823f11ffd2d4c838e961d61ec9ae8a646773.1707080349.git.dxu@dxuuu.xyz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dfd3823f11ffd2d4c838e961d61ec9ae8a646773.1707080349.git.dxu@dxuuu.xyz>

On Sun, Feb 04, 2024 at 02:06:34PM -0700, Daniel Xu wrote:
> Since 20d59ee55172 ("libbpf: add bpf_core_cast() macro"), libbpf is now
> exporting a const arg version of bpf_rdonly_cast(). This causes the
> following conflicting type error when generating kfunc prototypes from
> BTF:
> 
> In file included from skeleton/pid_iter.bpf.c:5:
> /home/dxu/dev/linux/tools/bpf/bpftool/bootstrap/libbpf/include/bpf/bpf_core_read.h:297:14: error: conflicting types for 'bpf_rdonly_cast'
> extern void *bpf_rdonly_cast(const void *obj__ign, __u32 btf_id__k) __ksym __weak;
>              ^
> ./vmlinux.h:135625:14: note: previous declaration is here
> extern void *bpf_rdonly_cast(void *obj__ign, u32 btf_id__k) __weak __ksym;

hi,
I'm hiting more of these when compiling bpf selftests (attached),
it looks like some kfuncs declarations in bpf_kfuncs.h might be in conflict

jirka


---
  CLNG-BPF [test_maps] connect_unix_prog.bpf.o
In file included from progs/connect_unix_prog.c:9:
/home/jolsa/kernel/linux-qemu/tools/testing/selftests/bpf/bpf_kfuncs.h:11:12: error: conflicting types for 'bpf_dynptr_from_skb'
extern int bpf_dynptr_from_skb(struct __sk_buff *skb, __u64 flags,
           ^
/home/jolsa/kernel/linux-qemu/tools/testing/selftests/bpf/tools/include/vmlinux.h:164853:12: note: previous declaration is here
extern int bpf_dynptr_from_skb(struct sk_buff *skb, u64 flags, struct bpf_dynptr_kern *ptr__uninit) __weak __ksym;
           ^
In file included from progs/connect_unix_prog.c:9:
/home/jolsa/kernel/linux-qemu/tools/testing/selftests/bpf/bpf_kfuncs.h:19:12: error: conflicting types for 'bpf_dynptr_from_xdp'
extern int bpf_dynptr_from_xdp(struct xdp_md *xdp, __u64 flags,
           ^
/home/jolsa/kernel/linux-qemu/tools/testing/selftests/bpf/tools/include/vmlinux.h:164855:12: note: previous declaration is here
extern int bpf_dynptr_from_xdp(struct xdp_buff *xdp, u64 flags, struct bpf_dynptr_kern *ptr__uninit) __weak __ksym;
           ^
In file included from progs/connect_unix_prog.c:9:
/home/jolsa/kernel/linux-qemu/tools/testing/selftests/bpf/bpf_kfuncs.h:28:14: error: conflicting types for 'bpf_dynptr_slice'
extern void *bpf_dynptr_slice(const struct bpf_dynptr *ptr, __u32 offset,
             ^
/home/jolsa/kernel/linux-qemu/tools/testing/selftests/bpf/tools/include/vmlinux.h:164747:14: note: previous declaration is here
extern void *bpf_dynptr_slice(const struct bpf_dynptr_kern *ptr, u32 offset, void *buffer__opt, u32 buffer__szk) __weak __ksym;
             ^
In file included from progs/connect_unix_prog.c:9:
/home/jolsa/kernel/linux-qemu/tools/testing/selftests/bpf/bpf_kfuncs.h:37:14: error: conflicting types for 'bpf_dynptr_slice_rdwr'
extern void *bpf_dynptr_slice_rdwr(const struct bpf_dynptr *ptr, __u32 offset,
             ^
/home/jolsa/kernel/linux-qemu/tools/testing/selftests/bpf/tools/include/vmlinux.h:164749:14: note: previous declaration is here
extern void *bpf_dynptr_slice_rdwr(const struct bpf_dynptr_kern *ptr, u32 offset, void *buffer__opt, u32 buffer__szk) __weak __ksym;
             ^
In file included from progs/connect_unix_prog.c:9:
/home/jolsa/kernel/linux-qemu/tools/testing/selftests/bpf/bpf_kfuncs.h:40:12: error: conflicting types for 'bpf_dynptr_adjust'
extern int bpf_dynptr_adjust(const struct bpf_dynptr *ptr, __u32 start, __u32 end) __ksym __weak;
           ^
/home/jolsa/kernel/linux-qemu/tools/testing/selftests/bpf/tools/include/vmlinux.h:164781:12: note: previous declaration is here
extern int bpf_dynptr_adjust(struct bpf_dynptr_kern *ptr, u32 start, u32 end) __weak __ksym;
           ^
In file included from progs/connect_unix_prog.c:9:
/home/jolsa/kernel/linux-qemu/tools/testing/selftests/bpf/bpf_kfuncs.h:41:13: error: conflicting types for 'bpf_dynptr_is_null'
extern bool bpf_dynptr_is_null(const struct bpf_dynptr *ptr) __ksym __weak;
            ^
/home/jolsa/kernel/linux-qemu/tools/testing/selftests/bpf/tools/include/vmlinux.h:164783:13: note: previous declaration is here
extern bool bpf_dynptr_is_null(struct bpf_dynptr_kern *ptr) __weak __ksym;
            ^
In file included from progs/connect_unix_prog.c:9:
/home/jolsa/kernel/linux-qemu/tools/testing/selftests/bpf/bpf_kfuncs.h:42:13: error: conflicting types for 'bpf_dynptr_is_rdonly'
extern bool bpf_dynptr_is_rdonly(const struct bpf_dynptr *ptr) __ksym __weak;
            ^
/home/jolsa/kernel/linux-qemu/tools/testing/selftests/bpf/tools/include/vmlinux.h:164785:13: note: previous declaration is here
extern bool bpf_dynptr_is_rdonly(struct bpf_dynptr_kern *ptr) __weak __ksym;
            ^
In file included from progs/connect_unix_prog.c:9:
/home/jolsa/kernel/linux-qemu/tools/testing/selftests/bpf/bpf_kfuncs.h:43:14: error: conflicting types for 'bpf_dynptr_size'
extern __u32 bpf_dynptr_size(const struct bpf_dynptr *ptr) __ksym __weak;
             ^
/home/jolsa/kernel/linux-qemu/tools/testing/selftests/bpf/tools/include/vmlinux.h:164787:14: note: previous declaration is here
extern __u32 bpf_dynptr_size(const struct bpf_dynptr_kern *ptr) __weak __ksym;
             ^
In file included from progs/connect_unix_prog.c:9:
/home/jolsa/kernel/linux-qemu/tools/testing/selftests/bpf/bpf_kfuncs.h:44:12: error: conflicting types for 'bpf_dynptr_clone'
extern int bpf_dynptr_clone(const struct bpf_dynptr *ptr, struct bpf_dynptr *clone__init) __ksym __weak;
           ^
/home/jolsa/kernel/linux-qemu/tools/testing/selftests/bpf/tools/include/vmlinux.h:164789:12: note: previous declaration is here
extern int bpf_dynptr_clone(struct bpf_dynptr_kern *ptr, struct bpf_dynptr_kern *clone__uninit) __weak __ksym;
           ^
In file included from progs/connect_unix_prog.c:9:
/home/jolsa/kernel/linux-qemu/tools/testing/selftests/bpf/bpf_kfuncs.h:61:12: error: conflicting types for 'bpf_sk_assign_tcp_reqsk'
extern int bpf_sk_assign_tcp_reqsk(struct __sk_buff *skb, struct sock *sk,
           ^
/home/jolsa/kernel/linux-qemu/tools/testing/selftests/bpf/tools/include/vmlinux.h:164859:12: note: previous declaration is here
extern int bpf_sk_assign_tcp_reqsk(struct sk_buff *skb, struct sock *sk, struct bpf_tcp_req_attrs *attrs, int attrs__sz) __weak __ksym;
           ^
In file included from progs/connect_unix_prog.c:9:
/home/jolsa/kernel/linux-qemu/tools/testing/selftests/bpf/bpf_kfuncs.h:68:12: error: conflicting types for 'bpf_get_file_xattr'
extern int bpf_get_file_xattr(struct file *file, const char *name,
           ^
/home/jolsa/kernel/linux-qemu/tools/testing/selftests/bpf/tools/include/vmlinux.h:164691:12: note: previous declaration is here
extern int bpf_get_file_xattr(struct file *file, const char *name__str, struct bpf_dynptr_kern *value_ptr) __weak __ksym;
           ^
In file included from progs/connect_unix_prog.c:9:
/home/jolsa/kernel/linux-qemu/tools/testing/selftests/bpf/bpf_kfuncs.h:75:12: error: conflicting types for 'bpf_verify_pkcs7_signature'
extern int bpf_verify_pkcs7_signature(struct bpf_dynptr *data_ptr,
           ^
/home/jolsa/kernel/linux-qemu/tools/testing/selftests/bpf/tools/include/vmlinux.h:164689:12: note: previous declaration is here
extern int bpf_verify_pkcs7_signature(struct bpf_dynptr_kern *data_ptr, struct bpf_dynptr_kern *sig_ptr, struct bpf_key *trusted_keyring) __weak __ksym;
           ^
12 errors generated.
make: *** [Makefile:642: /home/jolsa/kernel/linux-qemu/tools/testing/selftests/bpf/connect_unix_prog.bpf.o] Error 1

