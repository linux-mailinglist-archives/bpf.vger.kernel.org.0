Return-Path: <bpf+bounces-56493-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EB0B3A98D6A
	for <lists+bpf@lfdr.de>; Wed, 23 Apr 2025 16:41:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7104A7AE2A4
	for <lists+bpf@lfdr.de>; Wed, 23 Apr 2025 14:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E957C27FD62;
	Wed, 23 Apr 2025 14:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZebEuXkN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2B327FD58;
	Wed, 23 Apr 2025 14:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745419281; cv=none; b=cVprkZZS0vnuqOPfPv8FlNQl7wVGbmVEHDMGe3y9npmvAvUqHhlPGYhdLjrtbTBJOq7QHXBZAqjkh9ukjs9zM7kaSopYBFsn4MkkEqZMlCa9QqZHQkYxijrFBw8QymPGHH2zN8RJ1qphmWIl9M2k/fdO6R2FwIP+7JdXU3cKhpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745419281; c=relaxed/simple;
	bh=LSv+72puYjw5bOpYmjZlT20L7XZXssOk3Xu53zcVZf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fMOXxwt+X1A9yjMbxTjD5VlQDGKmN9JdYOh1vU1SRDHaX/AMaIzO8cRdmECwT+TsEJ6ZZrmMdXzL5n1dNwp8d6EQW9r0I0nULWX4g1i8qehJBR7/9ld9anQ8SIOKgj0BmZEDDWgZSTrLwnQF0ulGik8CWcJ1PF2KJtpPV1Zlkeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZebEuXkN; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-22d95f0dda4so37848145ad.2;
        Wed, 23 Apr 2025 07:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745419278; x=1746024078; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LSv+72puYjw5bOpYmjZlT20L7XZXssOk3Xu53zcVZf0=;
        b=ZebEuXkN/lWivO+94JjUqIOftBuP3cT1B0YAPX9WYUL1pKk5pffECBHY4Q6zyfVnaB
         HCPFH4bBkGmd7PWZz95rFz3plClZPXW6B3B6GT8vTYKtmvssfV6ah1g+rb/4vuPIcdpu
         prxGK9cZhdK+hUYyavFL1ZP/ZUDJJUrADHXZZcxsERYTUGb33idLeJj+dXDJ1LgP/vdK
         NDPgGuuad3dEdDrIOhIsWFVBqzO5UhpgL9fMXAZwOVn6YUT7ZlDNnK9lL4nXBIZhN3J5
         wo5kornvKs7IwEj/ZWlsh7nYjsW71NW+2hoBzpWSiZcZWuKp+YplpXPOaOtmj2zYR1zh
         D7aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745419278; x=1746024078;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LSv+72puYjw5bOpYmjZlT20L7XZXssOk3Xu53zcVZf0=;
        b=bGg1FDkWa7gAiguWGvs97JI4jbtGUEtnABH/bpi58BabV7c23hln6jOS1xDQckuxU/
         Fl/aFcCz/cElHSdc3Q4wQSBSWXGOEbueWfUckh/q1ZhG1AjlkLTEvZ6w1xgxOsIx9/oB
         VooOayvtnfg1Nj4O+gG6H8sbQzIyASDlPjgcdUMCPy6SAOYVpyNJBFWVoi17CMrKqGkm
         tMvnOqVZXsamamdXYT/6GnDO5oXuIm4bCEgFe6VQW7oHm7heeMZQWq7iYeimhet4OY+p
         HR1ueYSbq6Tqz3apN2nVPdlt0NM0VUxrpcRbpYEbmS94egyJPZV2diEn6MxOoKnKOnjb
         ziTg==
X-Forwarded-Encrypted: i=1; AJvYcCUIG/aebxF6MnWogT3Xk+Sa7Mw6yBYQUVMaaimhh3tOuacg13MMS2TjuAff+Z7girmspiZrIUCDwnzud9va@vger.kernel.org, AJvYcCWNCExMdGyA0EBqdoPA+ibZMcBtWUjf9MjmnyzC/4pJqeaLbAYUxVacNaiRCpKU3oFq8Jk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2ow7zPLJPoY55xBGcsvwj7EMRdxHK6uD9vfCSUf0s/+gTTpfw
	SiMhL5HaLS3RextyM60PliWVdBKj+Xcseu3ewBtKAT5ONPtSf5w=
X-Gm-Gg: ASbGncvgs2kansLy4+hDq6KuF+jZlYjGDtKwANkOgoSn7+kjlIl6rrUJ6XmupggGQk/
	OFrCM5VtBnhRBjn47E3C+evzJSyfuEFQNtnXXPBqT8F8Hx11cgFztdL9pjHvvTi9bQP+E2EsUFg
	MCU5BNNzE0utmYaEGWpaBa/YeN8jXKz3/0Mb4E/xaG9urPg6YxRyNjV42A6V+8F/w0WtgilSaAG
	VttuKscCDDBskPPru+/c3YKBoSxxX/jtMz+zZ5Hcx8suITflbrxwlvrCteMKhglz4q+nQXQM3QW
	3UfzYXS/2KHps2grac3mMRsaq6Mhl7T5S1HzxKLi
X-Google-Smtp-Source: AGHT+IGDMJ7mVrs7MGpWDguaDL50Errcc6GUi2lzccVKv7XMdolZY/WHsJ2g0YXTG07aJRo3JnZyqA==
X-Received: by 2002:a17:902:ced0:b0:224:1ec0:8a1a with SMTP id d9443c01a7336-22c536423c5mr268699125ad.51.1745419278341;
        Wed, 23 Apr 2025 07:41:18 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-22c50fe0859sm105266865ad.246.2025.04.23.07.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 07:41:17 -0700 (PDT)
Date: Wed, 23 Apr 2025 07:41:17 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] xsk: respect the offsets when copying frags
Message-ID: <aAj8DfHJ_XZxrDSJ@mini-arch>
References: <20250423101047.31402-1-minhquangbui99@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250423101047.31402-1-minhquangbui99@gmail.com>

On 04/23, Bui Quang Minh wrote:
> Add the missing offsets when copying frags in xdp_copy_frags_from_zc().

Can you please share more about how you've hit this problem?
I don't see the caller of this function (xdp_build_skb_from_zc)
being used at all.

Alexander, do you have plans to use it? Or should we remove it for now?

