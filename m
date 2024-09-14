Return-Path: <bpf+bounces-39900-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D74D9790A5
	for <lists+bpf@lfdr.de>; Sat, 14 Sep 2024 13:47:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D81D92842D6
	for <lists+bpf@lfdr.de>; Sat, 14 Sep 2024 11:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 762551CF7B2;
	Sat, 14 Sep 2024 11:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bVUGYYRJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFEB4C96
	for <bpf@vger.kernel.org>; Sat, 14 Sep 2024 11:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726314454; cv=none; b=S/etbAMR/3WNp1ty0aBB3FjMoGKfhEwOak6U7wSfRcmuM+zXdZoi0cmAUWlXGLRLMiEaHu+BzOXfTd04smHVNsx1WkgX7DWtXcVyyedGwGzotsa8np8umHzY2fu8Njtc/IpFA+bCeoT4CbCqoNKa9u3SHrsl/ign6bHdP579JQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726314454; c=relaxed/simple;
	bh=aIbIZsM9D2zS+abKlDyHzRp3uzwJndEOuqNYVvTPr68=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jxVG/ntNfi9P+ugCaCVHfXoqiKryHXHDOM2ootkNmAlQccKtU+p4W1pYXdyN0ctx6qjl6gWOjBsAnQbZ2Bbm8x4NBIveStFArcweUTeBAA77nKsiTsOIxfVeUj1RSv9oAVFXcRjiYecWiMle4n2SJiGPSrbuYMhC2xQq/f9RHSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bVUGYYRJ; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5bef295a429so3968064a12.2
        for <bpf@vger.kernel.org>; Sat, 14 Sep 2024 04:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726314450; x=1726919250; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aIbIZsM9D2zS+abKlDyHzRp3uzwJndEOuqNYVvTPr68=;
        b=bVUGYYRJB+tjaOi/otyE+1z5FiCPABKtvQ9C+0n7Jep5qmUKVbaKcIhpHu+LNfh82A
         v6IGk4PHiH1TeC3MIJi7Wa3IL2TGcx5uyMnEvfOmqv1370DzyTDFH7454JRs3rzrasvS
         eWGl13CDix3fGmEKe/8J8rcZPAUlIxtma3W0bEBfSnT0JKT4fTMKQPCOTJCq5foO/Q3a
         l1aweMMQHVUFc5FXwCGuAk8OAATeica1M8hBG6BdMsuFGR9bab5NYZurcw2E0OhWv+zg
         Z/OdqtKK2YRupLY8QJfCTJMBRhDr84aXQRryVLwKxO3MJKqFE6BjgWnioDPIygvFA0kO
         Jvcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726314450; x=1726919250;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aIbIZsM9D2zS+abKlDyHzRp3uzwJndEOuqNYVvTPr68=;
        b=jxrd2ljMgyBmtkOWT9vnbHAMTWEruCj4qinNnHuFx6liUnyTufVl1qOI3i7yqr6o4I
         s19mvM4eXsddw8yks3WHAfNZi3Pg5L6MGRbvbZU6+VLSj7D9tTWaC6w5hJWeRvuIYTof
         bA4WrhfRyITWiRhq2lKGCs9xLFMMY4x2CCTsDtD8zY9SoR+C+7Vh4Yxt899KY9lQtuD0
         iUG22ckLu4fRV5EFDqZS3qve39xflBBgxZrzuy1kROMvQObDmaQ7t/sI2/Fxx+4Zo9k0
         EBnWo+tieDxzJaTpGjiI0/OoVdR3GBSM6IKLiLE+YY7cw3xVkKC3oV9OcjLIRGQXZ3xa
         khAw==
X-Forwarded-Encrypted: i=1; AJvYcCV9+b9M+S2Nhaz2muhbt5SbBIFRkxxLxnQh2EQn5NJTYCJlMC+wO4V8xg5sS2l10np12BM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJLfKKAGMr/5QSRVncOf60sRV3/fmFfBpXZzKVCaCKne6qq6FO
	sKbVm/Iizvrpld2V8Vro7Uz+Iu6RHD+5wanEV+SHc4BVFLFIsI+j/0sZrzoGhwuOnCqxSugpJx+
	74J4V8HPyldva1dtB3RYfZb3+5aKEflHX3MhA
X-Google-Smtp-Source: AGHT+IFtdrSxlO4oLPwyB3rc7pgzSuSRHZMIf4+9ownvSxFM74FNtfppj59QZ9sJ+X03DfBTWg5uNF5t1+P4iaYK+H4=
X-Received: by 2002:a05:6402:4012:b0:5c2:7699:fa95 with SMTP id
 4fb4d7f45d1cf-5c413e1ff4amr8494152a12.19.1726314448521; Sat, 14 Sep 2024
 04:47:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240914103226.71109-1-zhoufeng.zf@bytedance.com> <20240914103226.71109-2-zhoufeng.zf@bytedance.com>
In-Reply-To: <20240914103226.71109-2-zhoufeng.zf@bytedance.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 14 Sep 2024 13:47:17 +0200
Message-ID: <CANn89iLkmsLZHfp=K5Ho9_asVzmv03knj1n=aap9G+xhRaeBXA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/2] bpf: Fix bpf_get/setsockopt to tos not
 take effect when TCP over IPv4 via INET6 API
To: Feng zhou <zhoufeng.zf@bytedance.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, mykolal@fb.com, shuah@kernel.org, 
	alan.maguire@oracle.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	yangzhenze@bytedance.com, wangdongdong.6@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 14, 2024 at 12:32=E2=80=AFPM Feng zhou <zhoufeng.zf@bytedance.c=
om> wrote:
>
> From: Feng Zhou <zhoufeng.zf@bytedance.com>
>
> when TCP over IPv4 via INET6 API, bpf_get/setsockopt with ipv4 will
> fail, because sk->sk_family is AF_INET6. With ipv6 will success, not
> take effect, because inet_csk(sk)->icsk_af_ops is ipv6_mapped and
> use ip_queue_xmit, inet_sk(sk)->tos.
>
> Bpf_get/setsockopt use sk_is_inet() helper to fix this case.
>
> Signed-off-by: Feng Zhou <zhoufeng.zf@bytedance.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

