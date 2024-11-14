Return-Path: <bpf+bounces-44842-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0DAD9C8B9A
	for <lists+bpf@lfdr.de>; Thu, 14 Nov 2024 14:15:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6528A281A39
	for <lists+bpf@lfdr.de>; Thu, 14 Nov 2024 13:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 140351FB8A4;
	Thu, 14 Nov 2024 13:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LmwUwzfR"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475A71FB734
	for <bpf@vger.kernel.org>; Thu, 14 Nov 2024 13:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731589996; cv=none; b=hkYE0Y90suHXTLQtULrFDsH3l9EyDTTK7bH00ENz3UR0Q4yu6JWX7pEs+0cRN1+otv1NUzXJINBHZYN3WQMkiE8/EVKQ4rkt99yFLmiDVMFJj30V+NZgoVMb793lMFcZ1j2E9Bd/iyzObety/B8x6juayMRQzeuz+pG2WBTOjN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731589996; c=relaxed/simple;
	bh=BMqdEvSo2XGJTRPGsNA6sRZBHIQCF0fBhcmVmqff8lE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=swom7llgyCN87l/z8WZMn5+knEfXFHeXAiKyhO+Qstt6tv3648BF8YczP7pYethiwypT4sVu5GegavWBlSTTC0JE3/fKx8bX9O3KRMTNdoZlHOpNaoljuy5+zBp6Q5MFvB3rS6r929JeylbbKsZX2tUqS2yIOWGgpOXVbt0cu2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LmwUwzfR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731589993;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BMqdEvSo2XGJTRPGsNA6sRZBHIQCF0fBhcmVmqff8lE=;
	b=LmwUwzfRjXkY4thwfX73uLhrvejfug+lHfRpXeol7HkNfw60CsFZs71IR4dgjEUfvOAFkb
	bf4aEn4HEP3R0vuHPB4RZPEyMLUjwWHOBBeRK2EyQMmaVrHYS2sfUb3EVhRBO4xyHS+UYV
	UzcFz4xhGx3SSlOC4p0lAfHxtuszy60=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-42-J0-wJ5xXOL6aDZzrkz0TNw-1; Thu, 14 Nov 2024 08:13:12 -0500
X-MC-Unique: J0-wJ5xXOL6aDZzrkz0TNw-1
X-Mimecast-MFC-AGG-ID: J0-wJ5xXOL6aDZzrkz0TNw
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a9a0710ca24so61950566b.3
        for <bpf@vger.kernel.org>; Thu, 14 Nov 2024 05:13:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731589991; x=1732194791;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BMqdEvSo2XGJTRPGsNA6sRZBHIQCF0fBhcmVmqff8lE=;
        b=RfMs1BC/Zgz77hOdS0G/cjVkesY5HP0ufuzz/y71E1qUyrscVZoRV/iFFIHu+wxRGQ
         ohxH6SjHlOsGEOunj/WBTOibBSdqRs5oU0W/uX8NPUc39Ab8e/vx92SymvRG97t2MfHY
         fSQMNM35k+vcWmA9OZg5FzKKtRhoaB+vQROqCoapAcskjacy+asiJrrEXXcvTjXJB36z
         Sfj9Tvlp8bJMmCv6gW9xegyXe8wzBop/OOWQI4ZsWMHnf1Blktcz8Xv40MDGkuOFgLaR
         JwSxYdDqCtxL26WT1Hbt5Unqjz7nSLGKrrAzFlCeHZoEvQQqULMmJE7crJoF+R0YiqdT
         6XwA==
X-Forwarded-Encrypted: i=1; AJvYcCUUDSg607JYCwX9H+GkS/MIK3tVNZ3Sm8kO9EQHwl4DzmX9J2QFhIisSmuNI0UsMZOmZio=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMxdyCZjQ92/Gv3aft3qqinpENySxgcA+5HvX/tXeY4RabBY7R
	jgcpE3mbsvef6MJel5mth5QLSOMUMNLiwno4FRbBdXU32Mq6RYPzvs28mWNpO8VLxQHooEdrYbm
	WkYe47K3Bq/3U085D6VbkfZtnKxQ1Cw40rVeUJoG80NfuUNFZYA==
X-Received: by 2002:a17:906:da87:b0:a9a:7f87:904b with SMTP id a640c23a62f3a-aa1b10a373amr1064627966b.29.1731589990892;
        Thu, 14 Nov 2024 05:13:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEOyxFRsRS28SbNhlIJrT9v3tkoYAXjzIK+RwTYwfJqA2Fz4E6wn0BXG7P2/Dh7o754OHjiSg==
X-Received: by 2002:a17:906:da87:b0:a9a:7f87:904b with SMTP id a640c23a62f3a-aa1b10a373amr1064625166b.29.1731589990523;
        Thu, 14 Nov 2024 05:13:10 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20dffd742sm63384266b.109.2024.11.14.05.13.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 05:13:09 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 6074D164D081; Thu, 14 Nov 2024 14:13:08 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Felix Maurer <fmaurer@redhat.com>, bpf@vger.kernel.org
Cc: bjorn@kernel.org, magnus.karlsson@intel.com,
 maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, yoong.siang.song@intel.com,
 sdf@fomichev.me, netdev@vger.kernel.org, Michal Schmidt
 <mschmidt@redhat.com>
Subject: Re: [PATCH bpf] xsk: Free skb when TX metadata options are invalid
In-Reply-To: <edb9b00fb19e680dff5a3350cd7581c5927975a8.1731581697.git.fmaurer@redhat.com>
References: <edb9b00fb19e680dff5a3350cd7581c5927975a8.1731581697.git.fmaurer@redhat.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Thu, 14 Nov 2024 14:13:07 +0100
Message-ID: <87jzd6q7q4.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Felix Maurer <fmaurer@redhat.com> writes:

> When a new skb is allocated for transmitting an xsk descriptor, i.e., for
> every non-multibuf descriptor or the first frag of a multibuf descriptor,
> but the descriptor is later found to have invalid options set for the TX
> metadata, the new skb is never freed. This can leak skbs until the send
> buffer is full which makes sending more packets impossible.
>
> Fix this by freeing the skb in the error path if we are currently dealing
> with the first frag, i.e., an skb allocated in this iteration of
> xsk_build_skb.
>
> Fixes: 48eb03dd2630 ("xsk: Add TX timestamp and TX checksum offload suppo=
rt")
> Reported-by: Michal Schmidt <mschmidt@redhat.com>
> Signed-off-by: Felix Maurer <fmaurer@redhat.com>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


