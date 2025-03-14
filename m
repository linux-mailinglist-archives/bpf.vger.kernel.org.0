Return-Path: <bpf+bounces-54073-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6285BA61CD2
	for <lists+bpf@lfdr.de>; Fri, 14 Mar 2025 21:35:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CAE6A7A90B9
	for <lists+bpf@lfdr.de>; Fri, 14 Mar 2025 20:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0073204840;
	Fri, 14 Mar 2025 20:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eVCH7tNT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60191A2872;
	Fri, 14 Mar 2025 20:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741984531; cv=none; b=X1J71xMoTg9cMUlev0SgCqFXJI+eEw8pYmkVwLXUCn02WaefqY8666TOEAifP0wwe/U47UYX2q1DJivSUwJDeIQU+8Ozr24XxuyiWpKMdDIzv1ocnZrQm5neW0Sjc0nh40NJO2WGII8HXLaKAYKBdcjK9DkIZFefgnYJ5Xayq+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741984531; c=relaxed/simple;
	bh=y35moCP3XItPdmW0djksyvaUKSgqVbG7BR2LexXdQm0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LHYZhm85fv8yk92igNtSQoK1XsyqhHHeUTJQUjwMeVRzK1DpdgWpa45WAXy3P4sddGYW4efsg431t7+EPXsMHIQJg3XEhHN7wbU/5UfY4YO6VnrE5D9HyRgyvj/Gs20j39mwu+MCIt3JdyFwTA/mfAWg2Gj7/NnHu4N5BzVJSDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eVCH7tNT; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3913d45a148so2073896f8f.3;
        Fri, 14 Mar 2025 13:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741984528; x=1742589328; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xj8OXU2bswQnQmpSnQJFG1oDI/cU7j7n5fn2QP89/kU=;
        b=eVCH7tNTjlK3AGA1YNbVcvLZwtk7nyrg/ayo2kGelgdlRncWVI8w4xZtsg05wXMDAV
         9vkepS+0FdWpUKVZDDcoE61Xzt97WX9TADUTkegiR1R5dN6VqwznAUfgBKnzeO9Gm7LP
         fx/lNsISdPk8ECowRbD3MoFNIpddfK6fud3lVwiPcJvf4NjNtYBdChd7f3eynf7peDOv
         bn5xXW1YJVkfQQ/3ey/jUKlTN56EQU36NxWo574LNLvC9jdhQrXemiZGqgDle4LdbC/q
         zXlOG/crh8TaXwB2lkKQoL8UmW4bWVs6ZrlvgR62Idt4Td5VFGWBu0/4gUi1O/OQvCwz
         3xhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741984528; x=1742589328;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xj8OXU2bswQnQmpSnQJFG1oDI/cU7j7n5fn2QP89/kU=;
        b=qbWUXPVKpl/HuNjFRK6m/j4BTMgiRj27BuPcasIZUZ5UgjennHBRkir4b+Xj6K0P6r
         K3JlHhsRljLFeFZYoY3Ar8LxmAsOzjzevGGrhEyThVGYAe4Rkdhru63dh6sHRqYkvhHf
         Gs3HYt7VHZ09e7HPxglCLljXzbQtbfYjnZXLS5c8OVTqlfUZyIfHKd6nv0EtQtZiKEK9
         tJBfSTaRu3gu/wTjz70ZqvTPaMTKqIcuWR7XJp9hG2razMkNaR9YJ4SaUTYtFw1vNJj6
         CqhVUw04YPAd5b5XDqozcL4YdLh6SYndkCDIMG6NOdivQZQabDlmDMC0GrU0Ju6LpGsy
         urcA==
X-Forwarded-Encrypted: i=1; AJvYcCVKb5IKGUTqwZ3KVEhRUSvU5TJgkXPtSaAM3gaXY+Yu12Db2gVwUmE+QLBRELP7PJeiyZo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVqdX6fKZ7/V0zmFBSUGlOiiBfnfmJrzsnPFhdwQ36BhXjqFij
	bLD2DT46iCyA1A3lZ3KznEAWhS/ZLLVk7ewQOpr8eQrF++vkE4jqqiDCRADAHXX4rfyvKYNw+NE
	Y3xZQJ4/QQJjA1M8D2ZwcODDe1Xw=
X-Gm-Gg: ASbGncvRneU0uf7Tbd0PiN5aFfCbofSu7Oz3+oOyUxjmCm6WQAU4NmYEZ8Bo6cZ6+3k
	uGE0nKoNrvpaOZxQs3gSoJLsNx/496OeL5hRCkLGWGOg4/OBKn+zkBWWJIT82u+vomVj1UzCli3
	08m0dzI/1Yx8Mp3hmetn//JlvNSZ/ndeEAZIg8YaI7Bg==
X-Google-Smtp-Source: AGHT+IGH0ch1bpRz5RWqHDMS4g9AffQUWD+9A2kHZvynf07UyLhMFxGsDWEp9wG5QFc+R955GPU7Z696xKK+gW68c4I=
X-Received: by 2002:a5d:47c9:0:b0:390:e311:a8c7 with SMTP id
 ffacd0b85a97d-3971cd57eb0mr4909674f8f.5.1741984527781; Fri, 14 Mar 2025
 13:35:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250313190309.2545711-1-ameryhung@gmail.com> <20250313190309.2545711-13-ameryhung@gmail.com>
In-Reply-To: <20250313190309.2545711-13-ameryhung@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 14 Mar 2025 13:35:16 -0700
X-Gm-Features: AQ5f1JrxdaJ9NE3HKEoE5DW_GIwb70mVam9Srpg9jgTi_uEL8Ox4ots74az0sEw
Message-ID: <CAADnVQKrndZ25SuRj-Ofv8tA50XjTwVVyQWmasN94LT9zeV7JQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 12/13] selftests/bpf: Add a bpf fq qdisc to selftest
To: Amery Hung <ameryhung@gmail.com>
Cc: Network Development <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Kui-Feng Lee <sinquersw@gmail.com>, 
	=?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Jiri Pirko <jiri@resnulli.us>, Stanislav Fomichev <stfomichev@gmail.com>, 
	ekarani.silvestre@ccc.ufcg.edu.br, yangpeihao@sjtu.edu.cn, 
	Peilin Ye <yepeilin.cs@gmail.com>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 13, 2025 at 12:03=E2=80=AFPM Amery Hung <ameryhung@gmail.com> w=
rote:
>
> From: Amery Hung <amery.hung@bytedance.com>
>
> This test implements a more sophisticated qdisc using bpf. The bpf fair-
> queueing (fq) qdisc gives each flow an equal chance to transmit data. It
> also respects the timestamp of skb for rate limiting.
>
> Signed-off-by: Amery Hung <amery.hung@bytedance.com>
> ---
>  .../selftests/bpf/prog_tests/bpf_qdisc.c      |  24 +
>  .../selftests/bpf/progs/bpf_qdisc_fq.c        | 718 ++++++++++++++++++

On the look of it, it's a pretty functional qdisc.
Since bpftool supports loading st_ops,
please list commands bpftool and tc the one can enter
to use this qdisc without running selftests.

Probably at the comment section at the top of bpf_qdisc_fq.c

It also needs SPDX and copyright.

pw-bot: cr

