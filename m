Return-Path: <bpf+bounces-5275-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7300D7593FA
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 13:10:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BE8A1C2083F
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 11:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5CD11428E;
	Wed, 19 Jul 2023 11:06:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8714A14285
	for <bpf@vger.kernel.org>; Wed, 19 Jul 2023 11:06:38 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 159A1186
	for <bpf@vger.kernel.org>; Wed, 19 Jul 2023 04:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689764765;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6G25Wpf6urdNog1RrCIh1jSfsrggg+8NTa2ueC8cR3I=;
	b=gb3Q7rfDomN49daMS2AXKVnJ30frNlp3DRKWcWRm4H2HwxmslWK1XYtbXoxEVBr2MO/3jE
	IY0GYBJgW5aY3TOSkucOpHNvgIylCHLFPg+3wn8huhJfnPbtUwyJDWJY/nuOnfzfumOhZE
	Mj1Q8EFPsOUQAktXhqS2QLKmHOoWRzE=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-8DB1tBuCPVa6KBhf-bQmMQ-1; Wed, 19 Jul 2023 07:06:04 -0400
X-MC-Unique: 8DB1tBuCPVa6KBhf-bQmMQ-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-4fccf211494so5491895e87.0
        for <bpf@vger.kernel.org>; Wed, 19 Jul 2023 04:06:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689764761; x=1692356761;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6G25Wpf6urdNog1RrCIh1jSfsrggg+8NTa2ueC8cR3I=;
        b=iv/nhwXoIwsYGFril8i/9YrjmGmwMOlEi5DMrvSxeRzG02c5XDNccG8IdeWYOQgH94
         +Jb2UV1OV0nzciSUGmUCo7HHXYUTnU5dBNGNFW5DeubxfAQoSaCTI4QmkELUevzIM0vt
         VbZOBy6mb52CZk4Nk0kjt/Yy4/LqFjxJA3HIyz72oIZfMtqhl0zyjIfpu3NsGLCrBqlC
         vpODT+VquCsai64sjwnd0eDlfBCZ3u2qWVKTtAwrBTzCLklLsraAeSfnXJME3jvc5fHZ
         8c+yhbevhrdg2MLzbibYSXKKI00jFsgjLqSLJWjZVbnLMVboiXfmF8bKwPfKTVGvQz08
         SqqA==
X-Gm-Message-State: ABy/qLalC8XRuYqTzIbo3+ApwQVGHEO9ZAnRVFAFvJ2Ij73Rxe5J26AR
	1KEL+6n0Kvqmc9ybLPZteuKQVBEwa7sLJ8EADbFshuOkmt5Jl4Xajl3W/oGJIxejzQ7ou1nT8en
	zbE70V4VwiPvL3GzAeozB
X-Received: by 2002:a05:6512:2316:b0:4fd:d9dd:7a22 with SMTP id o22-20020a056512231600b004fdd9dd7a22mr96825lfu.26.1689764761273;
        Wed, 19 Jul 2023 04:06:01 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGVmVc0nOSbjtLvsVkw0Xfo9zLoMCLBrAktPo4kwD8j+ZtvK0aKteVH/Zyf6WXfLny5TxU5yw==
X-Received: by 2002:a05:6512:2316:b0:4fd:d9dd:7a22 with SMTP id o22-20020a056512231600b004fdd9dd7a22mr96797lfu.26.1689764760864;
        Wed, 19 Jul 2023 04:06:00 -0700 (PDT)
Received: from redhat.com ([2.52.16.41])
        by smtp.gmail.com with ESMTPSA id s13-20020a7bc38d000000b003fbd0c50ba2sm1419609wmj.32.2023.07.19.04.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 04:06:00 -0700 (PDT)
Date: Wed, 19 Jul 2023 07:05:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: kernel test robot <lkp@intel.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	virtualization@lists.linux-foundation.org,
	oe-kbuild-all@lists.linux.dev, Jason Wang <jasowang@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org,
	bpf@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH vhost v12 10/10] virtio_net: merge dma operations when
 filling mergeable buffers
Message-ID: <20230719070450-mutt-send-email-mst@kernel.org>
References: <20230719040422.126357-11-xuanzhuo@linux.alibaba.com>
 <202307191819.0tatknWa-lkp@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202307191819.0tatknWa-lkp@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 19, 2023 at 06:33:05PM +0800, kernel test robot wrote:
> Hi Xuan,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on v6.4]
> [cannot apply to mst-vhost/linux-next linus/master v6.5-rc2 v6.5-rc1 next-20230719]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Xuan-Zhuo/virtio_ring-check-use_dma_api-before-unmap-desc-for-indirect/20230719-121424
> base:   v6.4
> patch link:    https://lore.kernel.org/r/20230719040422.126357-11-xuanzhuo%40linux.alibaba.com
> patch subject: [PATCH vhost v12 10/10] virtio_net: merge dma operations when filling mergeable buffers
> config: i386-randconfig-i006-20230718 (https://download.01.org/0day-ci/archive/20230719/202307191819.0tatknWa-lkp@intel.com/config)
> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> reproduce: (https://download.01.org/0day-ci/archive/20230719/202307191819.0tatknWa-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202307191819.0tatknWa-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>    drivers/net/virtio_net.c: In function 'virtnet_rq_init_one_sg':
> >> drivers/net/virtio_net.c:624:41: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
>      624 |                 rq->sg[0].dma_address = (dma_addr_t)addr;
>          |                                         ^
>    drivers/net/virtio_net.c: In function 'virtnet_rq_alloc':
> >> drivers/net/virtio_net.c:682:28: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
>      682 |                 *sg_addr = (void *)(dma->addr + alloc_frag->offset - sizeof(*dma));
>          |                            ^


yea these casts are pretty creepy. I think it's possible dma_addr_t won't fit in a pointer
or a pointer won't fit in dma_addr_t.

> 
> vim +624 drivers/net/virtio_net.c
> 
>    619	
>    620	static void virtnet_rq_init_one_sg(struct receive_queue *rq, void *addr, u32 len)
>    621	{
>    622		if (rq->do_dma) {
>    623			sg_init_table(rq->sg, 1);
>  > 624			rq->sg[0].dma_address = (dma_addr_t)addr;
>    625			rq->sg[0].length = len;
>    626		} else {
>    627			sg_init_one(rq->sg, addr, len);
>    628		}
>    629	}
>    630	
>    631	static void *virtnet_rq_alloc(struct receive_queue *rq, u32 size,
>    632				      void **sg_addr, gfp_t gfp)
>    633	{
>    634		struct page_frag *alloc_frag = &rq->alloc_frag;
>    635		struct virtnet_rq_dma *dma;
>    636		struct device *dev;
>    637		void *buf, *head;
>    638		dma_addr_t addr;
>    639	
>    640		if (unlikely(!skb_page_frag_refill(size, alloc_frag, gfp)))
>    641			return NULL;
>    642	
>    643		head = (char *)page_address(alloc_frag->page);
>    644	
>    645		if (rq->do_dma) {
>    646			dma = head;
>    647	
>    648			/* new pages */
>    649			if (!alloc_frag->offset) {
>    650				if (rq->last_dma) {
>    651					/* Now, the new page is allocated, the last dma
>    652					 * will not be used. So the dma can be unmapped
>    653					 * if the ref is 0.
>    654					 */
>    655					virtnet_rq_unmap(rq, rq->last_dma, 0);
>    656					rq->last_dma = NULL;
>    657				}
>    658	
>    659				dev = virtqueue_dma_dev(rq->vq);
>    660	
>    661				dma->len = alloc_frag->size - sizeof(*dma);
>    662	
>    663				addr = dma_map_single_attrs(dev, dma + 1, dma->len, DMA_FROM_DEVICE, 0);
>    664				if (addr == DMA_MAPPING_ERROR)
>    665					return NULL;
>    666	
>    667				dma->addr = addr;
>    668				dma->need_sync = dma_need_sync(dev, addr);
>    669	
>    670				/* Add a reference to dma to prevent the entire dma from
>    671				 * being released during error handling. This reference
>    672				 * will be freed after the pages are no longer used.
>    673				 */
>    674				get_page(alloc_frag->page);
>    675				dma->ref = 1;
>    676				alloc_frag->offset = sizeof(*dma);
>    677	
>    678				rq->last_dma = dma;
>    679			}
>    680	
>    681			++dma->ref;
>  > 682			*sg_addr = (void *)(dma->addr + alloc_frag->offset - sizeof(*dma));
>    683		} else {
>    684			*sg_addr = head + alloc_frag->offset;
>    685		}
>    686	
>    687		buf = head + alloc_frag->offset;
>    688	
>    689		get_page(alloc_frag->page);
>    690		alloc_frag->offset += size;
>    691	
>    692		return buf;
>    693	}
>    694	
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki


