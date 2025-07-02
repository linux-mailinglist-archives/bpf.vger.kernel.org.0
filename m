Return-Path: <bpf+bounces-62107-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 625C5AF146B
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 13:47:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF9A63B4274
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 11:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CE3B2676E2;
	Wed,  2 Jul 2025 11:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="SyqiSTPh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBC31E520C
	for <bpf@vger.kernel.org>; Wed,  2 Jul 2025 11:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751456813; cv=none; b=DXz8NRrhnO73xs4M+rIh1QBn2TdAf+86LA44zl0bduJ6hJhkhw6QWxYRQsgJbRot7Wig5UA21u+oYkbl1FR+9vpv9iPmsHgNL0B1my+vpUf9qbgD5+NVe19oTOzFedzyNOauGoGlNZD88on+fsTfKyXwMle+3ok2fd6IKkCq1D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751456813; c=relaxed/simple;
	bh=B+ckTwhERKNBb1gQw1U8u0g+Bc8f/814LWyhbI7jr8Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ICU7C6dpkikmZJVdclWtBOt+33ERkHKy3JapvFcqoD/gHwGa6nQcjBGt1pW2UJFTLTWZW/YMvawV3jUdLo+rXpieKw93R+NM7YlfYDYulqIJL1fNZI2G1C3N+jMm9Fx3kuuitPTIYhhxMYG13nvdFftJjYJ2fUobE3xXX2CYoD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=SyqiSTPh; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ae0b6532345so1479104066b.1
        for <bpf@vger.kernel.org>; Wed, 02 Jul 2025 04:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1751456810; x=1752061610; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=B+ckTwhERKNBb1gQw1U8u0g+Bc8f/814LWyhbI7jr8Y=;
        b=SyqiSTPhhIys5zaHLq6k61MH5pjvQFvzQwjMnE6mm2ds65agR+c6FkHWDCYk7JH3aC
         MYh4wzsRIRShF3PVpdNYuSITR3R40cW5u9D1YDtQ7fIvmQREHbqrS1whhKij2DQYNK50
         gD1lFUVz51D5Gk+mCT9GvUuExmDlO9A+9AflC6PS9VNmj13VYxzi5gcDhXZJ6Sb4n2gD
         8pjzhIvSMpvLUQDd2C8rpZTLmmNIWFf7khQgpTqpd0dewsqvPn/lwl9Pk8AatBGJU9k8
         6tmCDhNBv/GojB7ojr7f7b+3D0N4S7Y3ISPIeFxNZhxlF5u4oEmrJPLGJGAlaMo7hvYF
         0NXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751456810; x=1752061610;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B+ckTwhERKNBb1gQw1U8u0g+Bc8f/814LWyhbI7jr8Y=;
        b=dw8iOaKsKlO5qYevuHmyLHFJ5VtkZ4VM7Zy4enxLF3n+ZCSFxq6PVVMD5ieQUUlCta
         h2E8zHnOoh73YNhTERcO+hKZohI25/PLkYc3WQSDIADIkUtRrU0bxp7L9rZ5KBzLAeA6
         i/HK9DttLuDRYPHGNQ4FkWUKy/6RwQHhSH2ceGG7DyEVVlYt8f0A4mP0gw9yPs4VQG8n
         iwE3XHujePbXYURW9lc0/EXnK8NYWEvHp0ddHoLIWtcdK4V6FGaCENQxS3VYPswIWsuk
         3yiIzUg+ckUJuufyuBgL/5BWT4Mv9E0/jF2gMidomdTinvwbhyYZ++4mkEgHlHxKrX0F
         WwwA==
X-Forwarded-Encrypted: i=1; AJvYcCWtzV6EkibKjH3dBMist+rkRLwgFCHrnENeOtzlLlZH81HLqsxP7UYl2rGbSllnXN5duas=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+jL7+NwTK8Z2J/vaEVl+GznLvl8ALidOR4QJO2zX1/BZyqmss
	+T5GWpcvH9cvRz9hIr545Iq7SvGToc1hr8R1Zw4OasNpdu3A9HbJC+jeivYT+l+/bUE=
X-Gm-Gg: ASbGncuX9RESuXKmqVheLHa1MkbLSYr3pyzMUfNc/5/8WOc8Sq7g2pLZ96Oz9bqMIDV
	M/epiiCohvzja9pKj3Rgg86RFQRvW9sILQf8kHD4k21B8YMbCA5QZQUK1Q6CT4uZezzw65B7l3n
	zCvi+UH8CSoZLZyKHtKjhUkjKqnRlW4AhrNaz01rUhsNpwQiDrX93p7My2hx7QdI7uSLy/BFJIo
	0hMn+luKiJ497IntJ/nMhfkezK+zA5qIbb2ymOSBwmfgOScHc+VMe2TptOP23liCHUOoNK3U7ff
	nd1dFETEjVKGiybdctCAZh1RDmE6vFPDzOh3dy9vX45CL9i3Awk2aBI=
X-Google-Smtp-Source: AGHT+IHn9IHAQjBFlntquHq7U7auo8n8gfpvyxwY1QPzU89J2geG4r9cCc7SijhW0jMSezFMElSy9A==
X-Received: by 2002:a17:906:c14c:b0:ae0:7e95:fb with SMTP id a640c23a62f3a-ae3c3843a2fmr207138766b.5.1751456810074;
        Wed, 02 Jul 2025 04:46:50 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2432::39b:e7])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae35365a02csm1061393766b.70.2025.07.02.04.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 04:46:49 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: netdev@vger.kernel.org,  bpf@vger.kernel.org,  john.fastabend@gmail.com,
  zijianzhang@bytedance.com,  zhoufeng.zf@bytedance.com,  Cong Wang
 <cong.wang@bytedance.com>
Subject: Re: [Patch bpf-next v4 3/4] skmsg: save some space in struct sk_psock
In-Reply-To: <20250701011201.235392-4-xiyou.wangcong@gmail.com> (Cong Wang's
	message of "Mon, 30 Jun 2025 18:12:00 -0700")
References: <20250701011201.235392-1-xiyou.wangcong@gmail.com>
	<20250701011201.235392-4-xiyou.wangcong@gmail.com>
Date: Wed, 02 Jul 2025 13:46:48 +0200
Message-ID: <87ikkan7br.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Jun 30, 2025 at 06:12 PM -07, Cong Wang wrote:
> From: Cong Wang <cong.wang@bytedance.com>
>
> This patch aims to save some space in struct sk_psock and prepares for
> the next patch which will add more fields.
>
> psock->eval can only have 4 possible values, make it 8-bit is
> sufficient.
>
> psock->redir_ingress is just a boolean, using 1 bit is enough.
>
> Reviewed-by: John Fastabend <john.fastabend@gmail.com>
> Signed-off-by: Cong Wang <cong.wang@bytedance.com>
> ---

We could probably tweak sk_psock_map_verd to map (SK_PASS, redir=true,
ingress=true) in to something like __SK_REDIR_INGRESS in the future, and
do away with psock->redir_ingress field completely.

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>

