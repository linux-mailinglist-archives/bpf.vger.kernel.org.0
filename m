Return-Path: <bpf+bounces-39697-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FB1B9762D4
	for <lists+bpf@lfdr.de>; Thu, 12 Sep 2024 09:38:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62D992818E5
	for <lists+bpf@lfdr.de>; Thu, 12 Sep 2024 07:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C877218E03D;
	Thu, 12 Sep 2024 07:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iPcTqjfQ"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8B218C90C
	for <bpf@vger.kernel.org>; Thu, 12 Sep 2024 07:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726126704; cv=none; b=bXVpQWN8vlwkVRgX54V5ABeQTitafMa4OmC/rKPpun8QuMZLgca0SaAbMiNr2DvT9gz2XxpCI7QzC2UdRK8dro43DzpUDWjI15K8pNfLA3rCEdf+GShrydnyCK771BoURA9cwzPfMfTPG7D6hKQTV+FRL12p8gCEIWtzt06FHGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726126704; c=relaxed/simple;
	bh=z3/ZlPRYKpImydcKEv/wyodhIpd9NvgY2Js54fR2fdA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S9RvC2TL3gdV1LCBU7p0Ro+FnvVRX3uo6/CwN58mqy0Ri10+ZZgY7J685aRzv3rCEvsIQfZYprbdNZ1i/8JvZVkIy0gwpABLFPAua84SfgFszYQs3ll41rEipWW0qXkOH1CBHQhzYhb2JrTrqYnZCnE2P958ZMVyDNC1lV4F4p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iPcTqjfQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726126701;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H4fBuBnCEidjmbeIEXnc/9CKuIY9TAKerLdXJtzxaNI=;
	b=iPcTqjfQ60j88uBIL6QT3hgh2XuNaftgSv1B9p1jTjdEkEkJboRW8BLEn+F8YP08TH7PyN
	THpIrpeO6dZviUfcEQIKToD1VckJtODKy++3irn0DmfiVG0rfkOI/d4BgBU6rPdA9TNijT
	v0xd85uiLpYFyTx+Gv4hByqkMPXJrIQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-96-sMM3ycpBO3GkQnbaNQyIoA-1; Thu, 12 Sep 2024 03:38:19 -0400
X-MC-Unique: sMM3ycpBO3GkQnbaNQyIoA-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-374c294d841so519441f8f.1
        for <bpf@vger.kernel.org>; Thu, 12 Sep 2024 00:38:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726126698; x=1726731498;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H4fBuBnCEidjmbeIEXnc/9CKuIY9TAKerLdXJtzxaNI=;
        b=aXejjSgzJRlfZzcgBWZzoJr4BRCwRKikBh+qif7JftlJ2w8nRo9hYyt0IxkbiY1Ny7
         ME2mqv0+y7ZXnov8kFH/PH6XM8VfafDsbGXp3Ox+fnLIazXXd03aYQy4LVQipz0Mp2Qg
         b7+sUh8Or2CAWEbLbTk+vDx0ALkukrmkKMyYg9MJfS3+ou+Psp5ZS6/+tSvpu0JlRrGb
         mEuIFW4X7wZ87yaEeELj98PycR/UajLEaJ3MipsJ7y6gjbwxXf2ROAbOVMit/JqxqBlm
         OwM3FsXI0gFp42o5fytJ+UAMeY1rSOQBzKxhtql/XchRwODMi6uAnBjI3+1uB26iezVR
         wSGw==
X-Forwarded-Encrypted: i=1; AJvYcCUHBXvzUmm2w1opxIFyjYF2JwNy0MkdUsMSsztcXiOYqNNQ6zVD753mmqp8eexIywMvhgQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZn6PVpp7+4VoVR/URoiB9TZw85GjVqtQ1Suz+MZO+Tt6zSui0
	C0UegKMVcgEktlM8UTZrEtX6OTS5yAFCXgPfnPja3KqtzCtq9C5tGTyBXCToQ5Gq4p8lxndaPo4
	uUCHcGxjXMaoMWeNP3mEsTHuC7KsAhYv3QLHNAnG8KAR51hSl/A==
X-Received: by 2002:adf:fcd1:0:b0:374:bd01:707c with SMTP id ffacd0b85a97d-378c2d55876mr1413299f8f.48.1726126698248;
        Thu, 12 Sep 2024 00:38:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEOO68ioJGvs/NwodO5lKd9xytWZxftBSaY9t/pTKbQ/jAAYNVMqH9/p8jEMuTR6sj3X/JFbg==
X-Received: by 2002:adf:fcd1:0:b0:374:bd01:707c with SMTP id ffacd0b85a97d-378c2d55876mr1413275f8f.48.1726126697433;
        Thu, 12 Sep 2024 00:38:17 -0700 (PDT)
Received: from redhat.com ([31.187.78.105])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378956767dasm13740647f8f.62.2024.09.12.00.38.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 00:38:16 -0700 (PDT)
Date: Thu, 12 Sep 2024 03:38:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	virtualization@lists.linux.dev, bpf@vger.kernel.org
Subject: Re: [PATCH net-next 03/13] virtio_ring: packed: harden dma unmap for
 indirect
Message-ID: <20240912030013-mutt-send-email-mst@kernel.org>
References: <20240820073330.9161-1-xuanzhuo@linux.alibaba.com>
 <20240820073330.9161-4-xuanzhuo@linux.alibaba.com>
 <20240911072537-mutt-send-email-mst@kernel.org>
 <1726124138.2346847-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1726124138.2346847-1-xuanzhuo@linux.alibaba.com>

On Thu, Sep 12, 2024 at 02:55:38PM +0800, Xuan Zhuo wrote:
> On Wed, 11 Sep 2024 07:28:36 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > As gcc luckily noted:
> >
> > On Tue, Aug 20, 2024 at 03:33:20PM +0800, Xuan Zhuo wrote:
> > > @@ -1617,23 +1617,24 @@ static void detach_buf_packed(struct vring_virtqueue *vq,
> > >  	}
> > >
> > >  	if (vq->indirect) {
> > > +		struct vring_desc_extra *extra;
> > >  		u32 len;
> > >
> > >  		/* Free the indirect table, if any, now that it's unmapped. */
> > > -		desc = state->indir_desc;
> > > -		if (!desc)
> >
> > desc is no longer initialized here
> 
> 
> Will fix.
> 
> 
> >
> > > +		extra = state->indir;
> > > +		if (!extra)
> > >  			return;
> > >
> > >  		if (vring_need_unmap_buffer(vq)) {
> > >  			len = vq->packed.desc_extra[id].len;
> > >  			for (i = 0; i < len / sizeof(struct vring_packed_desc);
> > >  					i++)
> > > -				vring_unmap_desc_packed(vq, &desc[i]);
> > > +				vring_unmap_extra_packed(vq, &extra[i]);
> > >  		}
> > >  		kfree(desc);
> >
> >
> > but freed here
> >
> > > -		state->indir_desc = NULL;
> > > +		state->indir = NULL;
> > >  	} else if (ctx) {
> > > -		*ctx = state->indir_desc;
> > > +		*ctx = state->indir;
> > >  	}
> > >  }
> >
> >
> > It seems unlikely this was always 0 on all paths with even
> > a small amount of stress, so now I question how this was tested.
> > Besides, do not ignore compiler warnings, and do not tweak code
> > to just make compiler shut up - they are your friend.
> 
> I agree.
> 
> Normally I do this by make W=12, but we have too many message,
> so I missed this.
> 
> 	make W=12 drivers/net/virtio_net.o drivers/virtio/virtio_ring.o
> 
> If not W=12, then I did not get any warning message.
> How do you get the message quickly?
> 
> Thanks.


If you stress test this for a long enough time, and with
debug enabled, you will see a crash.


> >
> > >
> > > --
> > > 2.32.0.3.g01195cf9f
> >


