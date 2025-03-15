Return-Path: <bpf+bounces-54110-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40982A62F19
	for <lists+bpf@lfdr.de>; Sat, 15 Mar 2025 16:27:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85F10179E8E
	for <lists+bpf@lfdr.de>; Sat, 15 Mar 2025 15:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6B932045A8;
	Sat, 15 Mar 2025 15:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NeKTDbpI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com [209.85.208.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7324F2040B2
	for <bpf@vger.kernel.org>; Sat, 15 Mar 2025 15:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742052407; cv=none; b=OCmXwb2GQ2KwXRfJagLLgrKfy5HBXwVjjHY/+ybZq90EZ00asVvyAR4jgARNYQKF9F6VxWsnTFSM/LcrSaZ5cohNtJ9oeBzvVCnEaE6fykucgxnOszHKQ1QaA4CXkyCB9vyzW8LgCBTur0YRvBnb5/uaU5urBf6UkyasD1HQPK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742052407; c=relaxed/simple;
	bh=aA+HECtJIonwucn8BcWj80mEUaYSaCZUww2Cmv2hrVY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A/kD5q1tGY06zLL26fdvxK1MYyJTFQFddrxy+LOCxrUrXtovJPIT6lSS0x19fB/7eMcX3W90yKgZPh6+cwX1RdPsfLG1mvyRvpUbwIjIvUAd5nadyH3oCauKeuXhNG4OlPhBTJPTq3z3QRDlwx5SPZtADojD8wXJbPKzCrmXgoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NeKTDbpI; arc=none smtp.client-ip=209.85.208.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f67.google.com with SMTP id 4fb4d7f45d1cf-5e5deb6482cso7491539a12.1
        for <bpf@vger.kernel.org>; Sat, 15 Mar 2025 08:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742052404; x=1742657204; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aA+HECtJIonwucn8BcWj80mEUaYSaCZUww2Cmv2hrVY=;
        b=NeKTDbpIiJusY1EPdQdppN7RK+DnNiHXSyXXPi8wrm5rc0SVAuzN14P/xd7P5vnGJy
         gHkhuHtBmlOAplEoqjKZGqIAsK26od4RashnB6ZLARgyJuc/MMkQdlMnq3wcrrZvcZB8
         mminIJEsrUH82AmVSNujg9BExuLALC2VhLX++o3K27WQQ2pDa05kQ1pnzwDZi/xx/C6U
         T4SqThOrts3ajd1D4dEwPaHS9KsO1OmKUYcTQfW5UxB15zcAeZHo5lplOMj44VWloupp
         w0jcBhAh6Tmr0XE+LhLxJiaZXp8tX2WT7DNFPVlA+ikEZgdNAEyyOhEe5nUp2VcqVFjP
         Irbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742052404; x=1742657204;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aA+HECtJIonwucn8BcWj80mEUaYSaCZUww2Cmv2hrVY=;
        b=ReIZx5h8eb/dYFrkmDaH2vBdKLDY1NmVeLTode9vr1AB7BqiXhB4dSgXYRr6gDJulv
         5bSftn2x7COrOg0Q9XqUCZUBlgf8vP1dQpAkkSKAxM6NFP8CQUNfZCoDBK+5dXPmEnP3
         Jk4H70gHZhSf3tb+K42XUvURSnOs5O7RTkvH+9udpUrJ1rAquoU0kfcOb7digA4+E1ts
         I/BtXx7VHFm2uiVdhGOUiu06XDEezz5S6qbZddoDKNMvOcIq+2mJQb6ufWyttDIWiLpG
         D8fD0wuZvZDYx35dh7iiVK9vwlAdF6hjeXO82m3DodA761cWy66lD9OJQup+tdyD4aRg
         AYkw==
X-Gm-Message-State: AOJu0YyR5CZzhSfurRuUlE3MSZri7zRIixWfa3aNn1DOuDkeiS+29IXf
	qV1FAPdH+dx4ixImGqHXzX9pcXRzudSG6i0lhNVFkE3d2wwG6elVDY2VibPytidrJJab7cbvw69
	XBRUNkQ+pd92A2XML+1fPxd1zlAU=
X-Gm-Gg: ASbGncvS7phY5pu0Ip4PqbmhNypaM9X3v2IItHlMJyk8dHYtsHpnjcnYCv+l8Tmjo82
	64/YpSLjB4W3jyhb6ANdsHO4QIvnhhjKzpcqBzG72qo9PfhIKxHrpbebQLrpCWqyHeRxAAyYDzM
	TyWVLtlKI9m61vI+/VKSDzbpGfErYabDVtWJYR1U20TJUySO0=
X-Google-Smtp-Source: AGHT+IE8X9BMLA70TA6ZRx6W8Nl7r/Kb4QPOvd/tVViYUjwxZNg3RsMSvKlFPXO2pUjKc9pikY32fyKHQBZ/DghuJ7c=
X-Received: by 2002:a17:907:a78a:b0:abf:6e87:5148 with SMTP id
 a640c23a62f3a-ac3125055ecmr1150805066b.23.1742052403426; Sat, 15 Mar 2025
 08:26:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250315150930.1511727-1-houtao@huaweicloud.com>
In-Reply-To: <20250315150930.1511727-1-houtao@huaweicloud.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Sat, 15 Mar 2025 16:26:07 +0100
X-Gm-Features: AQ5f1JrXexE9a3CNhh7bYLBwpm2pL81Pvp6Md-d-M3_peEhGUZzxnvjzokbbB3o
Message-ID: <CAP01T77iP8tKe+0ua+DTpRKW6wQFo5G+SCZo8KEuFu7sWnHSUA@mail.gmail.com>
Subject: Re: [RESEND][PATCH bpf-next] bpf: Check map->record at the beginning
 of check_and_free_fields()
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, houtao1@huawei.com
Content-Type: text/plain; charset="UTF-8"

On Sat, 15 Mar 2025 at 15:57, Hou Tao <houtao@huaweicloud.com> wrote:
>
> From: Hou Tao <houtao1@huawei.com>
>
> When there are no special fields in the map value, there is no need to
> invoke bpf_obj_free_fields(). Therefore, checking the validity of
> map->record in advance.
>
> After the change, the benchmark result of the per-cpu update case in
> map_perf_test increased by 40% under a 16-CPU VM.
>
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

