Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB8204D2BD2
	for <lists+bpf@lfdr.de>; Wed,  9 Mar 2022 10:25:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231264AbiCIJ0n (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Mar 2022 04:26:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbiCIJ0n (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Mar 2022 04:26:43 -0500
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEA0D158798;
        Wed,  9 Mar 2022 01:25:43 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R281e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=33;SR=0;TI=SMTPD_---0V6j9G9H_1646817937;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0V6j9G9H_1646817937)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 09 Mar 2022 17:25:38 +0800
Message-ID: <1646817926.9029093-7-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v7 13/26] virtio: queue_reset: struct virtio_config_ops add callbacks for queue_reset
Date:   Wed, 9 Mar 2022 17:25:26 +0800
From:   Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Vadim Pasternak <vadimp@nvidia.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Cornelia Huck <cohuck@redhat.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        linux-um@lists.infradead.org, platform-driver-x86@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, bpf@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
References: <20220308123518.33800-1-xuanzhuo@linux.alibaba.com>
 <20220308123518.33800-14-xuanzhuo@linux.alibaba.com>
 <a3782384-c7e5-b0b3-6529-3aa3b8b589de@redhat.com>
In-Reply-To: <a3782384-c7e5-b0b3-6529-3aa3b8b589de@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 9 Mar 2022 16:47:11 +0800, Jason Wang <jasowang@redhat.com> wrote:
>
> =E5=9C=A8 2022/3/8 =E4=B8=8B=E5=8D=888:35, Xuan Zhuo =E5=86=99=E9=81=93:
> > Performing reset on a queue is divided into four steps:
> >
> >   1. reset_vq()                     - notify the device to reset the qu=
eue
> >   2. virtqueue_detach_unused_buf()  - recycle the buffer submitted
> >   3. virtqueue_reset_vring()        - reset the vring (may re-alloc)
> >   4. enable_reset_vq()              - mmap vring to device, and enable =
the queue
> >
> > So add two callbacks reset_vq, enable_reset_vq to struct
> > virtio_config_ops.
> >
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
> >   include/linux/virtio_config.h | 11 +++++++++++
> >   1 file changed, 11 insertions(+)
> >
> > diff --git a/include/linux/virtio_config.h b/include/linux/virtio_confi=
g.h
> > index 4d107ad31149..d51906b1389f 100644
> > --- a/include/linux/virtio_config.h
> > +++ b/include/linux/virtio_config.h
> > @@ -74,6 +74,15 @@ struct virtio_shm_region {
> >    * @set_vq_affinity: set the affinity for a virtqueue (optional).
> >    * @get_vq_affinity: get the affinity for a virtqueue (optional).
> >    * @get_shm_region: get a shared memory region based on the index.
> > + * @reset_vq: reset a queue individually (optional).
> > + *	vq: the virtqueue
> > + *	Returns 0 on success or error status
> > + *	Caller should guarantee that the vring is not accessed by any funct=
ions
> > + *	of virtqueue.
>
>
> We probably need to be more accurate here:
>
> 1) reset_vq will guarantee that the callbacks are disabled or synchronized
> 2) except for the callback, the caller should guarantee ...

OK.

Thanks.

>
> Thanks
>
>
> > + * @enable_reset_vq: enable a reset queue
> > + *	vq: the virtqueue
> > + *	Returns 0 on success or error status
> > + *	If reset_vq is set, then enable_reset_vq must also be set.
> >    */
> >   typedef void vq_callback_t(struct virtqueue *);
> >   struct virtio_config_ops {
> > @@ -100,6 +109,8 @@ struct virtio_config_ops {
> >   			int index);
> >   	bool (*get_shm_region)(struct virtio_device *vdev,
> >   			       struct virtio_shm_region *region, u8 id);
> > +	int (*reset_vq)(struct virtqueue *vq);
> > +	int (*enable_reset_vq)(struct virtqueue *vq);
> >   };
> >
> >   /* If driver didn't advertise the feature, it will never appear. */
>
