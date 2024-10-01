Return-Path: <bpf+bounces-40657-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F2C98BAF8
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 13:27:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D931283A9B
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 11:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DED21BF802;
	Tue,  1 Oct 2024 11:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H0eyakGY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ADA719AD4F
	for <bpf@vger.kernel.org>; Tue,  1 Oct 2024 11:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727782016; cv=none; b=ShSaPUHPt4MJbB3Ub2Uf8pxVMLmYCGOc/o9mMsD4W9kTVDFo5KxEpE+GcNkuPpPgy03lxy7Zq+VezzQ09W1kdkYhgWeTXLVoYRJZWCzJNYpLz0UL0xoelFTdl0R5kFgQwibnOtvSl8N+r0VU5D0UU0RfvJCkNwgk9chHR5Iaz2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727782016; c=relaxed/simple;
	bh=x0+qO8yWtx6HwzTSNEcw58WbAeMMTgVE47LvvDbXcw4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OUQDvlKs8WNf3UFWNaubSSKX45r6s14yV5dA9c6iGGkFmo4S8jN9V09/au4dzDUArxWUm42TqqiUxS9X6SdxVfBDQtrBszqdgaH03y7pJzPR8+2sQ7In6H7NQ1rO0v9tuUEiVI+dQWJtUjBOYcapDRocf/gz4f/+RccMb7LDZHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H0eyakGY; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-71b20ffd809so3995242b3a.0
        for <bpf@vger.kernel.org>; Tue, 01 Oct 2024 04:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727782015; x=1728386815; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8mlZKzcbrSL7cXUP39iXTU5p3P3HnlXZ0lKwwCXblRI=;
        b=H0eyakGYfW6IH2urwZ+GHdEogcVbYRjHQuZBhodzTU68/BNw/PSJ/yWWEBCtCft0at
         5YgD76BYYu/vCAKZZj99Qsiz8kjD3Sk7rnrKi283F7KZ/LeOqj1QmUYYQ7/dNd0JPUv0
         ICgEkvgak4HBVjqP8fkPXkHmDCDZEmeN5DlVbN0RtnBqAZKZgPr1a+0JqCpmX47ncBwX
         Wvzb3OMsyAq/xHzTgyDR4EKSVn5dXhWn5XYx6h+2erHQZ85SHlhVP90VcC1C4oDYZIfG
         CTJEtKDMl/q9SrID2zxlwZVAG37WJ14C0fALAYrapSCbG4GZ6W/tmuEmNK8SLDgewWx/
         0DNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727782015; x=1728386815;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8mlZKzcbrSL7cXUP39iXTU5p3P3HnlXZ0lKwwCXblRI=;
        b=foDJFb/ejak1onnahPFNIgfwctkqqF6REt37HMQFeVF5+PRsHl0YwKdBssTcuDUtyq
         jNFWgSvQEhpY/hwTnY8Xjs7Py2GMrmQk+BgivK6wAy5YztUYaO7vsNi7O+VfSbl68UDr
         0xMU929EYEr/Y8+a9JiTU5qfBkohE4B3IXaS/piJ2TfFHmgYV4sS17l95n1aKg/d0Qo+
         hKFTDGiWR9Tl6wxq00+XyU0PAXmWHrQ9N01iLklf1u1i3gVZOPKhxezZZU0QccS9VBbD
         AXVjnnrH0WCFi7E1VsiwH2QDM418BMmyXxS8o7ddx2Y2zQEB1W0ITNJLUNRgqCIMoiFN
         Pr9w==
X-Gm-Message-State: AOJu0YxTnsT5e6MRizW/BaFULN4ANiasaqnFfhkv2TuyYQnTv3ygvgZz
	sj+m49bFT2VaDn3KQRMhQyfehNk+NHaCj8ilRnpJPyh2GYG7JTx/
X-Google-Smtp-Source: AGHT+IHK5dwGUYCv9hQhIJMlT/Dp6RpqfW9u81l7+K7o9MirLegiPKcc/nR4WzPAoqm+y8SYbCFKbA==
X-Received: by 2002:a05:6a00:928a:b0:70d:3777:da8b with SMTP id d2e1a72fcca58-71b2607dd9cmr22373181b3a.25.1727782014558;
        Tue, 01 Oct 2024 04:26:54 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b264b63d9sm7803541b3a.52.2024.10.01.04.26.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 04:26:53 -0700 (PDT)
Message-ID: <adaa47618f2b71c2803195749cedd4a5b468cffa.camel@gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Add kfuncs for read-only string
 operations
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Viktor Malik
	 <vmalik@redhat.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>
Date: Tue, 01 Oct 2024 04:26:49 -0700
In-Reply-To: <CAEf4Bzas4ZxiyJp7h7N5OGmPSMRfZDgPUgEAdTmir3n-4cx-xg@mail.gmail.com>
References: <cover.1727329823.git.vmalik@redhat.com>
	 <bc06e1f4bef09ba3d431d7a7236303746a7adb57.1727329823.git.vmalik@redhat.com>
	 <CAEf4Bzas4ZxiyJp7h7N5OGmPSMRfZDgPUgEAdTmir3n-4cx-xg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-09-30 at 15:00 -0700, Andrii Nakryiko wrote:

[...]

> Right now, the only way to pass dynamically sized anything is through
> dynptr, AFAIU.

But we do have 'is_kfunc_arg_mem_size()' that checks for __sz suffix,
e.g. used for bpf_copy_from_user_str():

/**
 * bpf_copy_from_user_str() - Copy a string from an unsafe user address
 * @dst:             Destination address, in kernel space.  This buffer mus=
t be
 *                   at least @dst__sz bytes long.
 * @dst__sz:         Maximum number of bytes to copy, includes the trailing=
 NUL.
 * ...
 */
__bpf_kfunc int bpf_copy_from_user_str(void *dst, u32 dst__sz, const void _=
_user *unsafe_ptr__ign, u64 flags)

However, this suffix won't work for strnstr because of the arguments order.

[...]


