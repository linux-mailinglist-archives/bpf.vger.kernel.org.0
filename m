Return-Path: <bpf+bounces-17805-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC59812A31
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 09:20:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F1EF1F2164F
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 08:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C0B6171CC;
	Thu, 14 Dec 2023 08:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZLDu/6qq"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6260D114
	for <bpf@vger.kernel.org>; Thu, 14 Dec 2023 00:20:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702541999;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tRmYmYKdouaq3SuesAh37kIKzoyNX5WPg71KEcwVJ1U=;
	b=ZLDu/6qqoYFuOiSUXmwRisweFyNToeXMk1LKrZnrzJjipFzYiatNQQj9r58C0at44nNiR/
	2jYAj4GCEU4aOTSSu039PX4YEVVjV/0m+ALhmC8W74BMeQVXK0QGaufN4OzAR8NDRPvDaW
	HcFwLT83jPMemY5UNyJwAQ4P8WOuJb4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-151-Y97wH7IINlaUzg6j7YNTIQ-1; Thu, 14 Dec 2023 03:19:57 -0500
X-MC-Unique: Y97wH7IINlaUzg6j7YNTIQ-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3334b472196so6119264f8f.1
        for <bpf@vger.kernel.org>; Thu, 14 Dec 2023 00:19:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702541996; x=1703146796;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tRmYmYKdouaq3SuesAh37kIKzoyNX5WPg71KEcwVJ1U=;
        b=gHWSdLF33ypri6ogUdsK3EIK3mwV4JKvvbyCyVb9x5Qcb0IhXjFFMgJ8SMVD5PWqSa
         uvZkAyGTyZwlogQOL9Y91ULPiwG2IO7jn7ro3cvd7LGNZue1qUExabPyubg80YmFlCe0
         Fe45+WSeoPPg4nmdrrZeLNq82uNZa/dTg7EI/7fCehOfziIHk6J1oiVeiMPb8MRzjwE9
         ASQRWpJFuAKythqrtIG89spSrDFiKPnmnoLrPhn3vsLaOR0X/jFIpDybOt3CZeOtz2BS
         3OHde4wtAutzk292/xSW/kLS6cxLkrmE1gNrdVsEhqykSLuiQzNrExq1ZP55wn6TyAtU
         d19Q==
X-Gm-Message-State: AOJu0YxkkE9JGFO//d0+v3Cnv7++iixMgUBrg9JuUPUo7wIQ1s4dmTzk
	z0anjKOQI29sdKp9JJxehhDzDDK3FJGAlF6J0GrPMhdogWlJEoy7HugLQ3PmPunRfUrJkAZibnI
	4mrkQOEqzReaMdwt2P50Ug/o=
X-Received: by 2002:a05:6000:1c6:b0:336:4297:b25d with SMTP id t6-20020a05600001c600b003364297b25dmr957855wrx.136.1702541996582;
        Thu, 14 Dec 2023 00:19:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEdqvpfAVvf4U6RhyJKj4ac/lPlURzo1wv0qRFNbYaFyfMUYKbpbf2LJr5fGeJFUOmj7q8+yw==
X-Received: by 2002:a05:6000:1c6:b0:336:4297:b25d with SMTP id t6-20020a05600001c600b003364297b25dmr957779wrx.136.1702541996175;
        Thu, 14 Dec 2023 00:19:56 -0800 (PST)
Received: from sgarzare-redhat ([5.11.101.217])
        by smtp.gmail.com with ESMTPSA id c13-20020a5d4ccd000000b003363823d8aesm3920736wrt.59.2023.12.14.00.19.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 00:19:55 -0800 (PST)
Date: Thu, 14 Dec 2023 09:19:09 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Mina Almasry <almasrymina@google.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, 
	Michael Chan <michael.chan@broadcom.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, 
	Clark Wang <xiaoning.wang@nxp.com>, NXP Linux Team <linux-imx@nxp.com>, 
	Jeroen de Borst <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, 
	Shailend Chand <shailend@google.com>, Yisen Zhuang <yisen.zhuang@huawei.com>, 
	Salil Mehta <salil.mehta@huawei.com>, Jesse Brandeburg <jesse.brandeburg@intel.com>, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	Marcin Wojtas <mw@semihalf.com>, Russell King <linux@armlinux.org.uk>, 
	Sunil Goutham <sgoutham@marvell.com>, Geetha sowjanya <gakula@marvell.com>, 
	Subbaraya Sundeep <sbhatta@marvell.com>, hariprasad <hkelam@marvell.com>, Felix Fietkau <nbd@nbd.name>, 
	John Crispin <john@phrozen.org>, Sean Wang <sean.wang@mediatek.com>, 
	Mark Lee <Mark-MC.Lee@mediatek.com>, Lorenzo Bianconi <lorenzo@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Horatiu Vultur <horatiu.vultur@microchip.com>, 
	UNGLinuxDriver@microchip.com, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Jassi Brar <jaswinder.singh@linaro.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Siddharth Vadapalli <s-vadapalli@ti.com>, 
	Ravi Gunasekaran <r-gunasekaran@ti.com>, Roger Quadros <rogerq@kernel.org>, 
	Jiawen Wu <jiawenwu@trustnetic.com>, Mengyuan Lou <mengyuanlou@net-swift.com>, 
	Ronak Doshi <doshir@vmware.com>, VMware PV-Drivers Reviewers <pv-drivers@vmware.com>, 
	Ryder Lee <ryder.lee@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>, 
	Kalle Valo <kvalo@kernel.org>, Juergen Gross <jgross@suse.com>, 
	Stefano Stabellini <sstabellini@kernel.org>, Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Shakeel Butt <shakeelb@google.com>, 
	Yunsheng Lin <linyunsheng@huawei.com>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: Re: [RFC PATCH net-next v1 1/4] vsock/virtio: use skb_frag_page()
 helper
Message-ID: <nfhefym2w56uziqgzcloodvtf4wg74skoskhi6dztqqnlabhis@h4rj7p2ivvej>
References: <20231214020530.2267499-1-almasrymina@google.com>
 <20231214020530.2267499-2-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20231214020530.2267499-2-almasrymina@google.com>

On Wed, Dec 13, 2023 at 06:05:24PM -0800, Mina Almasry wrote:
>Minor fix for virtio: code wanting to access the page inside
>the skb should use skb_frag_page() helper, instead of accessing
>bv_page directly. This allows for extensions where the underlying
>memory is not a page.
>
>Signed-off-by: Mina Almasry <almasrymina@google.com>
>
>---
> net/vmw_vsock/virtio_transport.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

LGTM!

Acked-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>index af5bab1acee1..bd0b413dfa3f 100644
>--- a/net/vmw_vsock/virtio_transport.c
>+++ b/net/vmw_vsock/virtio_transport.c
>@@ -153,7 +153,7 @@ virtio_transport_send_pkt_work(struct work_struct *work)
> 				 * 'virt_to_phys()' later to fill the buffer descriptor.
> 				 * We don't touch memory at "virtual" address of this page.
> 				 */
>-				va = page_to_virt(skb_frag->bv_page);
>+				va = page_to_virt(skb_frag_page(skb_frag));
> 				sg_init_one(sgs[out_sg],
> 					    va + skb_frag->bv_offset,
> 					    skb_frag->bv_len);
>-- 
>2.43.0.472.g3155946c3a-goog
>


