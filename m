Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 774D42181ED
	for <lists+bpf@lfdr.de>; Wed,  8 Jul 2020 09:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbgGHH5a convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 8 Jul 2020 03:57:30 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:55862 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726081AbgGHH53 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Jul 2020 03:57:29 -0400
Received: from dggemi403-hub.china.huawei.com (unknown [172.30.72.56])
        by Forcepoint Email with ESMTP id 41A63D2E46B7DB4B1399;
        Wed,  8 Jul 2020 15:57:26 +0800 (CST)
Received: from DGGEMI424-HUB.china.huawei.com (10.1.199.153) by
 dggemi403-hub.china.huawei.com (10.3.17.136) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Wed, 8 Jul 2020 15:57:25 +0800
Received: from DGGEMI525-MBS.china.huawei.com ([169.254.6.177]) by
 DGGEMI424-HUB.china.huawei.com ([10.1.199.153]) with mapi id 14.03.0487.000;
 Wed, 8 Jul 2020 15:57:23 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>
CC:     =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn.topel@intel.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "maximmi@mellanox.com" <maximmi@mellanox.com>,
        "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
        "jonathan.lemon@gmail.com" <jonathan.lemon@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "magnus.karlsson@intel.com" <magnus.karlsson@intel.com>
Subject: RE: [PATCH net] xsk: remove cheap_dma optimization
Thread-Topic: [PATCH net] xsk: remove cheap_dma optimization
Thread-Index: AQHWS7/pzfMg3B6anUq8fHsEY1HhhKjq/YSAgACHKgCAAj1zgIABd7YAgA2QnQCAAJazMA==
Date:   Wed, 8 Jul 2020 07:57:23 +0000
Message-ID: <B926444035E5E2439431908E3842AFD255E99A@DGGEMI525-MBS.china.huawei.com>
References: <20200626134358.90122-1-bjorn.topel@gmail.com>
 <c60dfb5a-2bf3-20bd-74b3-6b5e215f73f8@iogearbox.net>
 <20200627070406.GB11854@lst.de>
 <88d27e1b-dbda-301c-64ba-2391092e3236@intel.com>
 <878626a2-6663-0d75-6339-7b3608aa4e42@arm.com> <20200708065014.GA5694@lst.de>
In-Reply-To: <20200708065014.GA5694@lst.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.200.214]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> -----Original Message-----
> From: netdev-owner@vger.kernel.org [mailto:netdev-owner@vger.kernel.org]
> On Behalf Of Christoph Hellwig
> Sent: Wednesday, July 8, 2020 6:50 PM
> To: Robin Murphy <robin.murphy@arm.com>
> Cc: Bj�rn T�pel <bjorn.topel@intel.com>; Christoph Hellwig <hch@lst.de>;
> Daniel Borkmann <daniel@iogearbox.net>; maximmi@mellanox.com;
> konrad.wilk@oracle.com; jonathan.lemon@gmail.com;
> linux-kernel@vger.kernel.org; iommu@lists.linux-foundation.org;
> netdev@vger.kernel.org; bpf@vger.kernel.org; davem@davemloft.net;
> magnus.karlsson@intel.com
> Subject: Re: [PATCH net] xsk: remove cheap_dma optimization
> 
> On Mon, Jun 29, 2020 at 04:41:16PM +0100, Robin Murphy wrote:
> > On 2020-06-28 18:16, Bj�rn T�pel wrote:
> >>
> >> On 2020-06-27 09:04, Christoph Hellwig wrote:
> >>> On Sat, Jun 27, 2020 at 01:00:19AM +0200, Daniel Borkmann wrote:
> >>>> Given there is roughly a ~5 weeks window at max where this removal
> could
> >>>> still be applied in the worst case, could we come up with a fix /
> >>>> proposal
> >>>> first that moves this into the DMA mapping core? If there is something
> >>>> that
> >>>> can be agreed upon by all parties, then we could avoid re-adding the 9%
> >>>> slowdown. :/
> >>>
> >>> I'd rather turn it upside down - this abuse of the internals blocks work
> >>> that has basically just missed the previous window and I'm not going
> >>> to wait weeks to sort out the API misuse.� But we can add optimizations
> >>> back later if we find a sane way.
> >>>
> >>
> >> I'm not super excited about the performance loss, but I do get
> >> Christoph's frustration about gutting the DMA API making it harder for
> >> DMA people to get work done. Lets try to solve this properly using
> >> proper DMA APIs.
> >>
> >>
> >>> That being said I really can't see how this would make so much of a
> >>> difference.� What architecture and what dma_ops are you using for
> >>> those measurements?� What is the workload?
> >>>
> >>
> >> The 9% is for an AF_XDP (Fast raw Ethernet socket. Think AF_PACKET, but
> >> faster.) benchmark: receive the packet from the NIC, and drop it. The DMA
> >> syncs stand out in the perf top:
> >>
> >>  � 28.63%� [kernel]������������������ [k] i40e_clean_rx_irq_zc
> >>  � 17.12%� [kernel]������������������ [k] xp_alloc
> >>  �� 8.80%� [kernel]������������������ [k] __xsk_rcv_zc
> >>  �� 7.69%� [kernel]������������������ [k] xdp_do_redirect
> >>  �� 5.35%� bpf_prog_992d9ddc835e5629� [k]
> bpf_prog_992d9ddc835e5629
> >>  �� 4.77%� [kernel]������������������ [k] xsk_rcv.part.0
> >>  �� 4.07%� [kernel]������������������ [k] __xsk_map_redirect
> >>  �� 3.80%� [kernel]������������������ [k]
> dma_direct_sync_single_for_cpu
> >>  �� 3.03%� [kernel]������������������ [k]
> dma_direct_sync_single_for_device
> >>  �� 2.76%� [kernel]������������������ [k]
> i40e_alloc_rx_buffers_zc
> >>  �� 1.83%� [kernel]������������������ [k] xsk_flush
> >> ...
> >>
> >> For this benchmark the dma_ops are NULL (dma_is_direct() == true), and
> >> the main issue is that SWIOTLB is now unconditionally enabled [1] for
> >> x86, and for each sync we have to check that if is_swiotlb_buffer()
> >> which involves a some costly indirection.
> >>
> >> That was pretty much what my hack avoided. Instead we did all the checks
> >> upfront, since AF_XDP has long-term DMA mappings, and just set a flag
> >> for that.
> >>
> >> Avoiding the whole "is this address swiotlb" in
> >> dma_direct_sync_single_for_{cpu, device]() per-packet
> >> would help a lot.
> >
> > I'm pretty sure that's one of the things we hope to achieve with the
> > generic bypass flag :)
> >
> >> Somewhat related to the DMA API; It would have performance benefits for
> >> AF_XDP if the DMA range of the mapped memory was linear, i.e. by IOMMU
> >> utilization. I've started hacking a thing a little bit, but it would be
> >> nice if such API was part of the mapping core.
> >>
> >> Input: array of pages Output: array of dma addrs (and obviously dev,
> >> flags and such)
> >>
> >> For non-IOMMU len(array of pages) == len(array of dma addrs)
> >> For best-case IOMMU len(array of dma addrs) == 1 (large linear space)
> >>
> >> But that's for later. :-)
> >
> > FWIW you will typically get that behaviour from IOMMU-based
> implementations
> > of dma_map_sg() right now, although it's not strictly guaranteed. If you
> > can weather some additional setup cost of calling
> > sg_alloc_table_from_pages() plus walking the list after mapping to test
> > whether you did get a contiguous result, you could start taking advantage
> > of it as some of the dma-buf code in DRM and v4l2 does already (although
> > those cases actually treat it as a strict dependency rather than an
> > optimisation).
> 
> Yikes.
> 
> > I'm inclined to agree that if we're going to see more of these cases, a new
> > API call that did formally guarantee a DMA-contiguous mapping (either via
> > IOMMU or bounce buffering) or failure might indeed be handy.
> 
> I was planning on adding a dma-level API to add more pages to an
> IOMMU batch, but was waiting for at least the intel IOMMU driver to be
> converted to the dma-iommu code (and preferably arm32 and s390 as well).
> 
> Here is my old pseudo-code sketch for what I was aiming for from the
> block/nvme perspective.  I haven't even implemented it yet, so there might
> be some holes in the design:
> 
> 
> /*
>  * Returns 0 if batching is possible, postitive number of segments required
>  * if batching is not possible, or negatie values on error.
>  */
> int dma_map_batch_start(struct device *dev, size_t rounded_len,
> 	enum dma_data_direction dir, unsigned long attrs, dma_addr_t *addr);
> int dma_map_batch_add(struct device *dev, dma_addr_t *addr, struct page
> *page,
> 		unsigned long offset, size_t size);
> int dma_map_batch_end(struct device *dev, int ret, dma_addr_t start_addr);
> 

Hello Christoph,

What is the different between dma_map_batch_add() and adding the buffer to sg of dma_map_sg()?

> int blk_dma_map_rq(struct device *dev, struct request *rq,
> 		enum dma_data_direction dir, unsigned long attrs,
> 		dma_addr_t *start_addr, size_t *len)
> {
> 	struct req_iterator iter;
> 	struct bio_vec bvec;
> 	dma_addr_t next_addr;
> 	int ret;
> 
> 	if (number_of_segments(req) == 1) {
> 		// plain old dma_map_page();
> 		return 0;
> 	}
> 
> 	// XXX: block helper for rounded_len?
> 	*len = length_of_request(req);
> 	ret = dma_map_batch_start(dev, *len, dir, attrs, start_addr);
> 	if (ret)
> 		return ret;
> 
> 	next_addr = *start_addr;
> 	rq_for_each_segment(bvec, rq, iter) {
> 		ret = dma_map_batch_add(dev, &next_addr, bvec.bv_page,
> 				bvec.bv_offset, bvev.bv_len);
> 		if (ret)
> 			break;
> 	}
> 
> 	return dma_map_batch_end(dev, ret, *start_addr);
> }
> 
> dma_addr_t blk_dma_map_bvec(struct device *dev, struct bio_vec *bvec,
> 		enum dma_data_direction dir, unsigned long attrs)
> {
> 	return dma_map_page_attrs(dev, bv_page, bvec.bv_offset, bvev.bv_len,
> 			dir, attrs);
> }
> 
> int queue_rq()
> {
> 	dma_addr_t addr;
> 	int ret;
> 
> 	ret = blk_dma_map_rq(dev, rq, dir, attrs. &addr, &len);
> 	if (ret < 0)
> 		return ret;
> 
> 	if (ret == 0) {
> 		if (use_sgl()) {
> 			nvme_pci_sgl_set_data(&cmd->dptr.sgl, addr, len);
> 		} else {
> 			set_prps();
> 		}
> 		return;
> 	}
> 
> 	if (use_sgl()) {
> 		alloc_one_sgl_per_segment();
> 
> 		rq_for_each_segment(bvec, rq, iter) {
> 			addr = blk_dma_map_bvec(dev, &bdev, dir, 0);
> 			set_one_sgl();
> 		}
> 	} else {
> 		alloc_one_prp_per_page();
> 
> 		rq_for_each_segment(bvec, rq, iter) {
> 			ret = blk_dma_map_bvec(dev, &bdev, dir, 0);
> 			if (ret)
> 				break;
> 			set_prps();
> 	}
> }

Thanks
Barry

