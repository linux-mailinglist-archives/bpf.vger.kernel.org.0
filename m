Return-Path: <bpf+bounces-31349-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 465D48FB885
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2024 18:08:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF57B286FA9
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2024 16:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C87371474BC;
	Tue,  4 Jun 2024 16:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NC9ON0Z5"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9D363E;
	Tue,  4 Jun 2024 16:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717517291; cv=none; b=BWAAc+5x+R6QI1pXPbp4MddCkvm26zxHc4kzsFoFPKaBgAkIknf76Rg1/DSPzCEK2y0MHqy+3NKSVXps0sEFOho98aXmu5XhMXmQDyGx9wXJGRCA842Edrzkm++HqK3JDnmfKiObqLqWAfZnv8F5Oz1j0+1g+e6cAam1bpgQ66E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717517291; c=relaxed/simple;
	bh=H2HIlkaXED8gB0sloo7KK9Oo7eSFd9/huUztb2+OG1s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=blUtk8kjqh+oKivGZFXggUFS4B/tNSd9Yac0AnFWXFrppPsLvUD7aFNwYb3Y7yEqTiyYsfBYkh2HMjLzJnDBjBGf9sNcfpKiOBeHjWDN7OcCRyYRcT5eIObwnjVM4jy3uer8Ox020t/R9eyQZdHh0KvtLbdlAwObmknTmtwLCCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NC9ON0Z5; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 454FqLos028995;
	Tue, 4 Jun 2024 16:07:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=pp1;
 bh=RYAEVIoHycrchhuGTQ5B6/ghysV0hQGRxAHCPa91+bM=;
 b=NC9ON0Z5in2RggNp7XjiZhu7jEreRuO3nBOV0EFodqGqXvs47AMB9ZvuBifM0buCQzQo
 lZpPhaUE1Ut+IKO3VqW4Sf2c59qvt8VqJkQ1XAz4OE3gqJOMBdTQblXMtzjHOPvhUXw0
 YiXKLfd98c/5670o0atW92kksHa5ZN3EhRSCNySdtBOJzkmiwPBxnT53U2GoRaqtATNQ
 VryJera6nHesWhwC2gmdMz6k/DP1iQWiNhVHF3st7Er5apPw3uks+gyihPBR40xS3xSX
 3At23unJ48DksCR4uUDrpGAPF0yJLGDACAIsyN9Ku1UrfWoxHJVElcNEoPY0URSl93+i YA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yj5xj01wp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Jun 2024 16:07:50 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 454G7nj7023839;
	Tue, 4 Jun 2024 16:07:49 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yj5xj01wg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Jun 2024 16:07:49 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 454F1F42000820;
	Tue, 4 Jun 2024 16:07:48 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ygdyty7e7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Jun 2024 16:07:48 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 454G7jgT32047800
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Jun 2024 16:07:47 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1470F20043;
	Tue,  4 Jun 2024 16:07:45 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B620720040;
	Tue,  4 Jun 2024 16:07:44 +0000 (GMT)
Received: from [9.152.222.105] (unknown [9.152.222.105])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  4 Jun 2024 16:07:44 +0000 (GMT)
Message-ID: <0b726a75574ad98200b815f173e59a5378e9df04.camel@linux.ibm.com>
Subject: Re: [PATCH vhost v13 04/12] virtio_ring: support add premapped buf
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        virtualization@lists.linux-foundation.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
 <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann
 <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John
 Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Alexander
 Potapenko <glider@google.com>
Date: Tue, 04 Jun 2024 18:07:44 +0200
In-Reply-To: <20230810123057.43407-5-xuanzhuo@linux.alibaba.com>
References: <20230810123057.43407-1-xuanzhuo@linux.alibaba.com>
	 <20230810123057.43407-5-xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: WehPitnWfUC5jfh6exx6tPPMtueHLvNr
X-Proofpoint-ORIG-GUID: wVeugmQrBeRs1Me48G1vRA0WmPdeGZ9y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-04_09,2024-06-04_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0 clxscore=1011
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406040129

On Thu, 2023-08-10 at 20:30 +0800, Xuan Zhuo wrote:
> If the vq is the premapped mode, use the sg_dma_address() directly.
>=20
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
> =C2=A0drivers/virtio/virtio_ring.c | 19 +++++++++++++++++--
> =C2=A01 file changed, 17 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/virtio/virtio_ring.c
> b/drivers/virtio/virtio_ring.c
> index 8e81b01e0735..f9f772e85a38 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -361,6 +361,11 @@ static struct device *vring_dma_dev(const struct
> vring_virtqueue *vq)
> =C2=A0static int vring_map_one_sg(const struct vring_virtqueue *vq, struc=
t
> scatterlist *sg,
> =C2=A0			=C2=A0=C2=A0=C2=A0 enum dma_data_direction direction,
> dma_addr_t *addr)
> =C2=A0{
> +	if (vq->premapped) {
> +		*addr =3D sg_dma_address(sg);
> +		return 0;
> +	}
> +

I wonder if something needs to be done for KMSAN here, like it's done
by the next block in this function? I'm looking into what seems to be a
KMSAN false positive on s390x:

BUG: KMSAN: uninit-value in receive_buf+0x45ca/0x6990            =20
 receive_buf+0x45ca/0x6990                                           =20
 virtnet_poll+0x17e0/0x3130                                          =20
 net_rx_action+0x832/0x26e0                                          =20
 handle_softirqs+0x330/0x10f0                                        =20
 [...]
                                                                           =
                             =20
Uninit was created at:                                               =20
 __alloc_pages_noprof+0x62a/0xe60                                    =20
 alloc_pages_noprof+0x392/0x830                                      =20
 skb_page_frag_refill+0x21a/0x5c0                                    =20
 virtnet_rq_alloc+0x50/0x1500                                        =20
 try_fill_recv+0x372/0x54c0                                          =20
 virtnet_open+0x210/0xbe0                                            =20
 __dev_open+0x56e/0x920                                              =20
 __dev_change_flags+0x39c/0x2000                                     =20
 dev_change_flags+0xaa/0x200                                         =20
 do_setlink+0x197a/0x7420                                            =20
 rtnl_setlink+0x77c/0x860                                            =20
 [...]

My understanding is that virtnet_rq_alloc() allocates a page for
receiving data from a virtio device, which is then wrapped in struct
scatterlist by virtnet_rq_init_one_sg(), which is in turn associated
with a virtqueue through the virtqueue_add_inbuf_ctx() ->
virtqueue_add() -> virtqueue_add_split() -> vring_map_one_sg()
call chain.

Someone should unpoison this page (since KMSAN doesn't know that the
hypervisor writes to it), and today for the non-premapped case this is
vring_map_one_sg(). So I tried the following naive fix:

        if (vq->premapped) {
                *addr =3D sg_dma_address(sg);
+               if (!vq->use_dma_api) {
+                       kmsan_handle_dma(phys_to_page(*addr), sg-
>offset, sg->length, direction);
+               }

but it didn't help. I plan to investigate this further, but any hints
are much appreciated.

> =C2=A0	if (!vq->use_dma_api) {
> =C2=A0		/*
> =C2=A0		 * If DMA is not used, KMSAN doesn't know that the
> scatterlist

