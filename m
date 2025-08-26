Return-Path: <bpf+bounces-66504-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A29C4B3530B
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 07:12:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C56B77A54C5
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 05:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37DF92E92B0;
	Tue, 26 Aug 2025 05:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U19QKdzT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29EFC2D0612;
	Tue, 26 Aug 2025 05:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756185155; cv=none; b=oWTdEpN3npwvo8z+9TVoWivxCEsIO6DQ8MfNT0EKCCzWP7Q79pXSA28bqHFDyQvL+jvIElKcREC00pjxX0ZQ1k9nmPi+xG4ChO3baqO0+6O/QdPiN64ikR7IchRg6Rw4tACxh5MAbDSE3RL77ELurUNi/wIY+57kuCGOoy4s35I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756185155; c=relaxed/simple;
	bh=9PGhLR8VStrpRka1BeqlGcLlMhfrmlqMmLbiG9SMikY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bNpSU4M7TF1IZzyd5MHolemcYwVazvu+1kxWMzLlUnj+PsEB70SzfdkFBC313sFDnGC8RkLuYJK5wYVfBkcVpN4FAVx900Dm1LSWOJITCShEaWdrPUsHmt/Li11aPmfHQqrnjs1kVmPRGbtl9geXoVqqdqq93vBQqYqLya4bZ2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U19QKdzT; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-71d6059fb47so41537817b3.3;
        Mon, 25 Aug 2025 22:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756185153; x=1756789953; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CzpOBfKpAOJe2A2Ez4b2Y3AbfowrudVL+0/mUwTfywA=;
        b=U19QKdzTVBhk9OGIzk49oTkVfFcmhjS4H1ON6dfPYjF1XGi55PeA8oxcGPNC0mtFcS
         8bPlU2PjgOe+CNDCGX91fEr45h6UpUt5+G7U1CwcXa4GY0xteUPyhKZZAwxMmdfymDYB
         WqAqsWPY8fsQrM3BSvJ1Y2eC5eHwPxap0yzpHZeB8QluD4qInbmueCXFQd13i4kcPMCh
         VovNfAXuVRJenLetVDQ24ECpE/tI4mj0BvjoBeOY9+ss04Pdw4gwbpUZ+Z4PWrTnJXWL
         ZldPG8bVtSxUKah/Fv6pROG5P8G/E2EWBTLlBvls2ASrJr/3Ti+LEaSKClzR+IHc4Wmm
         s5bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756185153; x=1756789953;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CzpOBfKpAOJe2A2Ez4b2Y3AbfowrudVL+0/mUwTfywA=;
        b=fQVbkPi+v0TGZGe63Nw5u3JocLFeQ2pc26bKsJa7/FLiFzZphevPeq7BbyI99xKWOA
         ecF4l6Kf9ygHOH8zGIQ+jlYZZ9aPWcmqJiUJU33rHNXC70vXdxu37X7maFEttrm4cfci
         fftGHKbLKA2pwS+Dk5yUqJrhUCkFN8Bw8HTUJhzxaA+xYBUU/wH3YFOxhiDwFsIYWbSG
         ap0vSsVKtxITV5q8yQR0d0BrbJg5DJHN6U2+y3ZrCoQ37wUVwdgwL7WWy0n8NnNlmwWi
         oQz3GCwSCOQS6QDWloG9Ljubdf2q+IPAsEhHWR9aEuK0HXuZ75gao6r+IY348wgmd2wt
         0CdQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6qo/Y/YDipNRl67v3G/w/pzRq7scbPGUorSQTz7Sh8MQNkmVpIXz4qnaL27XWUlXeU/cpUCk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaPJRG26U1+0pziBJiXMBITtTUVUujqlAD9jbaHijhNhTiPl6E
	Z9XvxL/a9Y/qbztZ9TWDfm1nYvbzIPlGZ86UKxYwqPR1//zBIWksrSgS1m+hoDhdnfP9VnYOw5u
	llQ0KJVxFm9zOc57RipAYkCAAx47DwE0=
X-Gm-Gg: ASbGncunYeA1jGZTM/obovir+dID6jZyJDvVMT2Y747/4/SumvcLVp5Cl+k/ZmRiuEy
	tBkJQxreZETDOabjfvOTNoVyNKi6v6bZJcjzKfFNGizXK8g71h5RvhltWSL7e/aLzzhYW1vT0JS
	pEW7PTfot1xb459DLkc9YvROqVKHHWMjpLw7CcMHwijh9l7mULdiiBGGY4D7LdbPM6Xmu43kKKU
	zgmtZ8=
X-Google-Smtp-Source: AGHT+IH4n2DNZWZ2VIn9XkxLuMx+IeWAomFwHhoaR80HTvDcAWp8kshYfGhdYWWtXAfhB+HXqWiicdRURBv7UJitE/Q=
X-Received: by 2002:a05:690c:4a02:b0:71f:efa8:5881 with SMTP id
 00721157ae682-71fefa85cedmr128878457b3.30.1756185152855; Mon, 25 Aug 2025
 22:12:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250825193918.3445531-1-ameryhung@gmail.com> <20250825193918.3445531-4-ameryhung@gmail.com>
 <20250825153923.0d98c69d@kernel.org>
In-Reply-To: <20250825153923.0d98c69d@kernel.org>
From: Amery Hung <ameryhung@gmail.com>
Date: Mon, 25 Aug 2025 22:12:21 -0700
X-Gm-Features: Ac12FXweyE8WQIt7ScTyEN9WPP3zp7WNQE2T7efvX7GsDeHVAMPBt8kNcETJnik
Message-ID: <CAMB2axP2c+tfYPvw7PiPRk11ZkTpvMdMnLRMgjgG697unhGEcA@mail.gmail.com>
Subject: Re: [RFC bpf-next v1 3/7] bpf: Support pulling non-linear xdp data
To: Jakub Kicinski <kuba@kernel.org>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org, 
	mohsin.bashr@gmail.com, saeedm@nvidia.com, tariqt@nvidia.com, 
	mbloch@nvidia.com, maciej.fijalkowski@intel.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 25, 2025 at 3:39=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Mon, 25 Aug 2025 12:39:14 -0700 Amery Hung wrote:
> > +__bpf_kfunc int bpf_xdp_pull_data(struct xdp_md *x, u32 len, u64 flags=
)
> > +{
> > +     struct xdp_buff *xdp =3D (struct xdp_buff *)x;
> > +     struct skb_shared_info *sinfo =3D xdp_get_shared_info_from_buff(x=
dp);
> > +     void *data_end, *data_hard_end =3D xdp_data_hard_end(xdp);
> > +     int i, delta, buff_len, n_frags_free =3D 0, len_free =3D 0;
> > +
> > +     buff_len =3D xdp_get_buff_len(xdp);
> > +
> > +     if (unlikely(len > buff_len))
> > +             return -EINVAL;
> > +
> > +     if (!len)
> > +             len =3D xdp_get_buff_len(xdp);
> > +
> > +     data_end =3D xdp->data + len;
> > +     delta =3D data_end - xdp->data_end;
> > +
> > +     if (delta <=3D 0)
> > +             return 0;
> > +
> > +     if (unlikely(data_end > data_hard_end))
> > +             return -EINVAL;
>
> Is this safe against pointers wrapping on 32b systems?
>

You are right. This may be a problem.

> Maybe it's better to do:
>
>          if (unlikely(data_hard_end - xdp->data_end < delta))
>
> ?

But delta may be negative if the pointer wraps around and then the
function will still continue. How about adding data_end < xdp->data
check and reorganizing the checks like this?

        buff_len =3D xdp_get_buff_len(xdp);

        /* cannot pull more than the packet size */
        if (unlikely(len > buff_len))
                return -EINVAL;

        len =3D len ?: buff_len;

        data_end =3D xdp->data + len;

        /* pointer wraps around */
        if (unlikely(data_end < xdp->data))
                return -EINVAL;

        /* cannot pull without enough tailroom in the linear area */
        if (unlikely(data_end > data_hard_end))
                return -EINVAL;

        /* len bytes of data already in the linear area */
        delta =3D data_end - xdp->data_end;
        if (delta <=3D 0)
                return 0;

>
> > +     for (i =3D 0; i < sinfo->nr_frags && delta; i++) {
> > +             skb_frag_t *frag =3D &sinfo->frags[i];
> > +             u32 shrink =3D min_t(u32, delta, skb_frag_size(frag));
> > +
> > +             memcpy(xdp->data_end + len_free, skb_frag_address(frag), =
shrink);
> > +
> > +             len_free +=3D shrink;
> > +             delta -=3D shrink;
> > +             if (bpf_xdp_shrink_data(xdp, frag, shrink, false))
> > +                     n_frags_free++;
>
> possibly
>
>                 else
>                         break;
>
> and then you don't have to check delta in the for loop condition?
>

I will drop the delta check and add the else branch. I will also make
the bpf_xdp_shrink_data() refactor in patch 2 consistent with this.

> > +     }
> > +
> > +     for (i =3D 0; i < sinfo->nr_frags - n_frags_free; i++) {
> > +             memcpy(&sinfo->frags[i], &sinfo->frags[i + n_frags_free],
> > +                    sizeof(skb_frag_t));
>
> This feels like it'd really want to be a memmove(), no?
>

Right. Thanks for the suggestion!


> > +     }
> > +
> > +     sinfo->nr_frags -=3D n_frags_free;
> > +     sinfo->xdp_frags_size -=3D len_free;
> > +     xdp->data_end =3D data_end;
> > +
> > +     if (unlikely(!sinfo->nr_frags))
> > +             xdp_buff_clear_frags_flag(xdp);
> > +
> > +     return 0;
> > +}

