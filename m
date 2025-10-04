Return-Path: <bpf+bounces-70384-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2552BB8FB6
	for <lists+bpf@lfdr.de>; Sat, 04 Oct 2025 18:16:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C51BF1897ADB
	for <lists+bpf@lfdr.de>; Sat,  4 Oct 2025 16:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2704C27EFE1;
	Sat,  4 Oct 2025 16:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MEBuwWWA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D6A27D782
	for <bpf@vger.kernel.org>; Sat,  4 Oct 2025 16:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759594579; cv=none; b=WrKG0f9feCgWAGLBIksXzcxZEdx074SS6GQcOSoDlkoX7lEx6EXNEvYtUDmn+o0uC2SECfwoomcREmX4+ZcmRLo2bVPryCQ0jA+5X+/x3b+ptqLt2svDSZoxj3TYgHV3xkz7MRDlc2hB5FFh+16JReKlI7p/FNMp88MHjAzmykA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759594579; c=relaxed/simple;
	bh=BFtFWz45fCHfJppYTWPt51ZzCzGvzVWdQH30FH6IQUc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c123/oaZeW0evjExeuMCwMiJOf2LLGVttfPl0U1bCdvkMcm1P9Gc8rZjDNXKSAwd3ZPmv5VhN2eIfyfCME35496Q1+FsKVrF/mzD+gqYKtMTKPwXyPs3wYO8otmgIIKeFsRLPqxwuU2/O1Ry3Jf6HmAL71qbnL5Edez2RecxXM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MEBuwWWA; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-42557c5cedcso1786241f8f.0
        for <bpf@vger.kernel.org>; Sat, 04 Oct 2025 09:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759594576; x=1760199376; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BFtFWz45fCHfJppYTWPt51ZzCzGvzVWdQH30FH6IQUc=;
        b=MEBuwWWA9jG+HkRdcJFUB/0ltpuZgooele6Ye5mDK+4vq96J1dYnFPwL77ItXw5KyF
         6LhBiMF6o81Mb5hhyyDhYnILOzIBLgTZX2m1wQw3BIofmoya+kdnDViUNOCX2sQMswYH
         uWz8xBj6op4IWnPsAN2atKfCuL1V9wIgBom3uDtrZb0J6kH31fJmIOeUYCvYg3IMKffG
         Zx5B/lGX54JMm68jvoLD5xYdiJbNd6R/Jc0xit/8+g9mohzPHsW0OqK1U/A5glGdyEWP
         z/Tc39KnyDXiMne35jPL7ver7a2sfWgg//dDYvCpANgGoIsXQfqrSyh5+vInGzKFYrB9
         j/XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759594576; x=1760199376;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BFtFWz45fCHfJppYTWPt51ZzCzGvzVWdQH30FH6IQUc=;
        b=tjY6nmv0lCGwstkU/rSgnVrMIF/BZ217eddTctP0tzwn7BKzaSn565dDetK7Vr9Dpb
         Gpyw7BGpqUKaT+FXzt9uXbUQ9TS+dZ01zUy/pH7KYeU69D501QS5rZsFMnBsWwrJRqu+
         nTBBhH5lQVN9lvojaj9CoTmpzEAbpnzDbvBoncGz0C/eqFYvfMbWUIaY9BZ5h0U26zaZ
         2dqYLpmOlyEPa5SnlOETql8D2lMIQL5Y+gCjy1FPl1tKxN0xBdBFInbSGGVa4XOUZOJu
         EyWO0A5FSGBfrUQh6NjLrKzSWNCuimVeeszO7gvurvN5FAqNF1D9HHyNGxGvxvPGcsaw
         y37w==
X-Forwarded-Encrypted: i=1; AJvYcCW+AmV42/nz9qMu12qHH8XvXIdS6sa3HD+Nr8Im2FSVPMZaAW8hiRYYGzX5DFzI0uPZlVw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmEUjnfZE4Fa8U/wQiFXrQ+vT9J+mBnJFHUOjGL4FiMPdsjsO6
	RWNu4Z4sPif6zGpwa9a8IUwbNMZtn5pzu5EJ3qwxowIaUWY9RVSi2cI1XsmoqiTdA9BazwBFRcL
	rm9IDTZCiYwoIzk33Bzn6zciSD9VDmfE=
X-Gm-Gg: ASbGncvb6rai3wkEpHCCmsAgULjI5cjBA0Hv/RyjjyBT52NCcmEnmjpQItgT54lyNuq
	AM0TX3E/MvvG4Pxt2hZPrJ7PsgkjyZcZv5Rhtz23x0/pKlGcf0FJXsqsKzZVmKYRkiKM4Ga/7Xm
	l63QdFIyco0tAcbFWmZmBr8YaDwM6UEvQ+JM7P66ahVR8L97ZDmLrFNprj/2+kq5gwh3v/Sg0Ee
	4AHarpklRcek5O3/kSWWBdtEDIYMpfD2Uce2B5S8shvn/Iz1Yx73oxfbH+XHQemzhkD33I=
X-Google-Smtp-Source: AGHT+IG/MV88gOTgIBtKglK8w1B5S7CgfnDOr0uIJuq9YH1xAWacU7h3e14hKjJmdWrb0tfBYx6T3oHJx47i8VNfTVc=
X-Received: by 2002:a05:6000:2401:b0:3ea:e0fd:28e8 with SMTP id
 ffacd0b85a97d-4256719e9c6mr4129999f8f.32.1759594575949; Sat, 04 Oct 2025
 09:16:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tencent_1259E1972E2A9FAF3DA342882306E1421308@qq.com>
In-Reply-To: <tencent_1259E1972E2A9FAF3DA342882306E1421308@qq.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 4 Oct 2025 09:16:04 -0700
X-Gm-Features: AS18NWCQqriAfAUku8dSRijSYcwsuw4WSLelAlUXdhySmf6if1b2NeynApQdIj0
Message-ID: <CAADnVQJ5oEi0iiS+_N1f=K+0oTdDswGiESrd1tve_F_7aMOCBQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf_doc: Support 1st const parameter of bpf_d_path()
To: Rong Tao <rtoax@foxmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Rong Tao <rongtao@cestc.cn>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Jason Xing <kerneljasonxing@gmail.com>, 
	Willem de Bruijn <willemb@google.com>, Paul Chaignon <paul.chaignon@gmail.com>, 
	Tao Chen <chen.dylane@linux.dev>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin Kelly <martin.kelly@crowdstrike.com>, Anton Protopopov <a.s.protopopov@gmail.com>, 
	Matt Bobrowski <mattbobrowski@google.com>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Al Viro <viro@zeniv.linux.org.uk>, 
	"open list:BPF [GENERAL] (Safe Dynamic Programs and Tools)" <bpf@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 4, 2025 at 7:24=E2=80=AFAM Rong Tao <rtoax@foxmail.com> wrote:
>
> From: Rong Tao <rongtao@cestc.cn>
>
> Since commit 1b8abbb12128 ("bpf...d_path(): constify path argument"),
> the first parameter of the bpf_d_path() has been changed to a const
> constant. We need to modify the header file and bpf_doc.py.

...

> Fixes: 1b8abbb12128 ("bpf...d_path(): constify path argument")
> Signed-off-by: Rong Tao <rongtao@cestc.cn>

Thanks. I reworded the commit message and applied it to the bpf tree.

