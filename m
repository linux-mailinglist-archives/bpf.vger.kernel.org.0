Return-Path: <bpf+bounces-67354-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05AA4B42D6D
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 01:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF83E1738A9
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 23:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BA322E8E1F;
	Wed,  3 Sep 2025 23:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kqMCSkDl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42578288D6;
	Wed,  3 Sep 2025 23:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756942211; cv=none; b=FQs9A8axxzDm9EbmSfVDUN7gL3GpFVGaxVz2rqRhvi89HgJ1plJNnN/mF5iErKrFiUUWWWsdyCTVba6ke/t9En2suMTAVUYup4mxj/GBR7Dw9G2TdRAvBq+ZJCgevo7lv8tFuY1Fjb3vhW2PYtgrMz7Y+VtItXz5XB0w6+2DQwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756942211; c=relaxed/simple;
	bh=tOm1R75Zi2GL1DQGYVjsuIqlob093ahY7XWmOs55O34=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=biWAALc/zepZtE4TTyr6Ci1pZxfoyaNvG8tXSGrUWdqic9B5CtFj2UwxY/AGJTae8TNKPqWhidDMBm+AZ6C/aZb0k+1+UPK0h6d1nx28xjm76hEur1Opx1Ju3VIgMGxZ6npQ4Xc+66onJS53a9I1yh6gEufxkjEmf+9RdisBMIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kqMCSkDl; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3c68ac7e18aso337644f8f.2;
        Wed, 03 Sep 2025 16:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756942208; x=1757547008; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tOm1R75Zi2GL1DQGYVjsuIqlob093ahY7XWmOs55O34=;
        b=kqMCSkDlDqvtKnSWYKpawSVRWRzk7cqGx1fGp9B95WXvfUeTw/NrV4CFn+w/o0+ddf
         Tex0lkAuk5jrwVVWUGXk8ioqHbZ3PD7XCHmc6La98UBqNnBG3n6PWSwH/SJwa0OTZIdh
         /OAqgjgw7olL09VNCY0ZG0iqksRVYmByFnfn5zOaQOZ+PO7kZfeE5pS1U4WDfIJwULtT
         vn+rJGBYxX6ALIZTfuBUiP7gyJKrV/ZP2RqMCrh3rZjhGQIgXjVgtx/ROMu3wIwhGs59
         87ZGSI4hlQn1q7mb+lLMUJ6aXJa7Dn7ZMf/qhD38XY6wYczPnN+4GKZ3s1fSZM/u8r3Q
         4TsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756942208; x=1757547008;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tOm1R75Zi2GL1DQGYVjsuIqlob093ahY7XWmOs55O34=;
        b=ZEm8eDqoABgB8BYnVcpuZLfbMEyEJk75unMZWxRqnMX9HwBXXaIqWkAtryneaKnMck
         KK2QFi+XlLbmROQ+/8nyTwXsX/zeht0323Ic/kCRx48rR6Aa03nXzeIPQ00u+iRotWgh
         TCUqVBh6iZk3WA10qpge2Eogh6eoqSlsWY07M5rTWjyVVRdiFU1dQx44DEtNxLYNKk/N
         1WIJVm33a6JAvb7eZylW49/Ule115b5r2PNH+Dxu+TRdnHau0vY7IXnPTU95UX2JuzS6
         dRRn04gYYhHio0aO4ahH9zz9t0o861jl/ANXgIt5c5k/95BmVD+LfkCs8Qq+rmDXYsAV
         HTcA==
X-Forwarded-Encrypted: i=1; AJvYcCV30UfDgQaWPRU9czMatvZKHj5zOJqBXndJNQsZGm/cMiscvjhjBS83Us0Tm85IWqUaPu8qTiT/Fw2qHx8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcyzY3QaTD+x89ECJE1Ki415LaGB9xYB6ML/QAnS2P4GEcSPSB
	olc553S7c7PswcrROF0/9aNjengFgOtNOjlrhnHIsaociz7Wg9MPN7W5/SXgg7Hrt+zrJQn447l
	JMtixHGQkV99wP0hxSmHYAyNwKaSGKCrcRA==
X-Gm-Gg: ASbGncv39qDFzsTtgqkTPDE39IyuPPTP2/cRFjbfTE0H+PCZ/pWYzXHXpb5YoFsoccX
	pi74mNkQkyLU+fgbyO7PPJgO1nkgKBCiXQalpOuRT+2omI6PxG10nEQb6PGewx0hZdoxkq1Quj2
	T8w5eN5agW4LoFDOHd2ZI0uiJl+RfLBdlt9cPFPg1eue/e1YhxXrhHM1HmwHaDS01Ys4wHr5d4h
	NfepmrMyJBoF7O/fawHKqGMQE0=
X-Google-Smtp-Source: AGHT+IF8L+179v7vSkAjD+bromtswbvUOupCSyrcswKJhAD2VV08XKPi+T9IgPnIoqK8NoCe4YXPUlVRK2uAgChZMZg=
X-Received: by 2002:a5d:5d02:0:b0:3d5:55c9:f210 with SMTP id
 ffacd0b85a97d-3d555c9f811mr11167080f8f.40.1756942208337; Wed, 03 Sep 2025
 16:30:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250903175841.232537-1-dwindsor@gmail.com>
In-Reply-To: <20250903175841.232537-1-dwindsor@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 3 Sep 2025 16:29:57 -0700
X-Gm-Features: Ac12FXwgCupOKB0mkWN2xGH5nrgWQIsf7aDXwPjHSZDu08GuMBC_E3mNaiTQHuA
Message-ID: <CAADnVQLRhdLkZB8wFybofC8P8AP9sruMHzaYJbB4zUAKAv87dA@mail.gmail.com>
Subject: Re: [PATCH 1/2] kernel/bpf: Add BPF_MAP_TYPE_CRED_STORAGE map type
 and kfuncs
To: David Windsor <dwindsor@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 10:58=E2=80=AFAM David Windsor <dwindsor@gmail.com> =
wrote:
>
> All other bpf local storage is obtained using helpers which benefit from
> RET_PTR_TO_MAP_VALUE_OR_NULL, so can return void * pointers directly to
> map values. kfuncs don't have that, so return struct
> bpf_local_storage_data * and access map values through sdata->data.

The commit log tells nothing about motivation for such "cred local storage"=
.
Technically it's doable, but sorry not going to.
cred is not something that needs fast access and automatic lifetime
management. Use hash map with 'struct cred *' as a key.

pw-bot: cr

