Return-Path: <bpf+bounces-19338-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B9F982A0E2
	for <lists+bpf@lfdr.de>; Wed, 10 Jan 2024 20:15:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7292285D75
	for <lists+bpf@lfdr.de>; Wed, 10 Jan 2024 19:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C25144E1C2;
	Wed, 10 Jan 2024 19:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f1oRklxr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC75A4D5AF;
	Wed, 10 Jan 2024 19:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-555f581aed9so5297990a12.3;
        Wed, 10 Jan 2024 11:15:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704914130; x=1705518930; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=41lpfdueieQfrzn2GM7CXNzHqpSPhXGHpp4P6ZTjuX8=;
        b=f1oRklxrbPhQbQvcDxp8DzY81YJIrzf2Ym3OzsXbUL5OqkeVRvK3q7QpppiDkdqyA/
         +RHXXBvT4WCDRn/zSUULRYEDthNv6/+owOC8LFKCtI9q9Fs2TGatJeYfpz6hCho3Oq8q
         NZI27o0ItbVXIu4EBlJ69O2StITBpTn6nCikcuriQUJpLbJsgsPkWqPqeOg/PggW1J9J
         dZfGd2T1a2Xm9WQt6/N9OZFgfXgcLV0Ch2x8zADfFbBwxvptuhNNH7BiuP3lNQgZxmQ7
         vODH41K5nBdCQS5RbatpZTaGODshz0JkZP2sHQ0J5wThgXr5F9aOF2VoPRWvRr5xWwo4
         XQ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704914130; x=1705518930;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=41lpfdueieQfrzn2GM7CXNzHqpSPhXGHpp4P6ZTjuX8=;
        b=qU7MHx8Wyfy0pGB5PqvQLmNucW8mZf81JjJmQHc+7qypWOkMbYJSCorXyZUj7QZSEs
         g+LeCjOjfGKyV3ZiAOAezPRnzH37vj+kqiJ+TEU9zwmySBzk6RPXY2yTpM07wYvwoo6o
         PnsScc5cbDaq8cZQbWYHW3nFkcAkJN2CqFZBoaxK7mdNSCzE1p5fWyzkTeeL4blO6om5
         tdXDkDUobn8Za1/eHWDoAvHlv5HPThkdl+0pa7dPofIAbG+2LSytSwBIiqoi6nEX9VrO
         BoPMUQwieGF/89DhuLVnUGUrcdqwrXh09bwh5LYdyKdN9pKo4k94406oLQtxhSAWfFN7
         cqAA==
X-Gm-Message-State: AOJu0Yxz4Un9hDjs48tOaBw3OuZccwFpw26RmWP0tFZgMpZqmxC0zmM+
	jqu2uHmeTz0sTx0KodqxA9J2coeyEpHw8NSOZfu6yFJS
X-Google-Smtp-Source: AGHT+IF8vkAzBkZAIeJbSxx3hkH1JlBWY4JjumpzHswcjiU5wNRgaci7YEyu7xhqgmIH135JpP+ZoNjnwAvi3TXI5oA=
X-Received: by 2002:a50:c008:0:b0:558:5fe0:213c with SMTP id
 r8-20020a50c008000000b005585fe0213cmr753042edb.28.1704914130053; Wed, 10 Jan
 2024 11:15:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEf4BzYMx_TbBY4yeK_iJqq65XHY5V3yQQ1PzfOh6OMQwyz5cA@mail.gmail.com>
 <20240110091509.1155824-1-nogikh@google.com>
In-Reply-To: <20240110091509.1155824-1-nogikh@google.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 10 Jan 2024 11:15:18 -0800
Message-ID: <CAEf4BzaZOJumas-UYgoU96PS8kfJ0xsgYFfyhEmWBcpSsP7zdQ@mail.gmail.com>
Subject: Re: Re: [syzbot] [bpf?] WARNING in __mark_chain_precision (3)
To: Aleksandr Nogikh <nogikh@google.com>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, sdf@google.com, 
	song@kernel.org, syzbot+4d6330e14407721955eb@syzkaller.appspotmail.com, 
	syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2024 at 1:15=E2=80=AFAM Aleksandr Nogikh <nogikh@google.com=
> wrote:
>
>
> > #syz fix: 482d548d bpf: handle fake register spill to stack with
> > BPF_ST_MEM instruction
>
> It needs to stay on one line, otherwise only part of the title
> is considered.

Gmail is not very cooperative here, unfortunately. Thanks!

>
> #syz fix: bpf: handle fake register spill to stack with BPF_ST_MEM instru=
ction

