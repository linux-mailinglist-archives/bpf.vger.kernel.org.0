Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7C56D5938
	for <lists+bpf@lfdr.de>; Tue,  4 Apr 2023 09:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233770AbjDDHMU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 4 Apr 2023 03:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233570AbjDDHMT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 4 Apr 2023 03:12:19 -0400
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B31CD173E;
        Tue,  4 Apr 2023 00:12:16 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0VfKhaH3_1680592332;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0VfKhaH3_1680592332)
          by smtp.aliyun-inc.com;
          Tue, 04 Apr 2023 15:12:13 +0800
Message-ID: <1680592019.471209-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next 3/8] virtio_net: introduce virtnet_xdp_handler() to seprate the logic of run xdp
Date:   Tue, 4 Apr 2023 15:06:59 +0800
From:   Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        virtualization@lists.linux-foundation.org, bpf@vger.kernel.org
References: <20230328120412.110114-1-xuanzhuo@linux.alibaba.com>
 <20230328120412.110114-4-xuanzhuo@linux.alibaba.com>
 <CACGkMEvZ=-G4QVTDnoSa1N0UspW8u_oz-7xosrXV0f1YcytVXw@mail.gmail.com>
 <1680495148.1559556-3-xuanzhuo@linux.alibaba.com>
 <CACGkMEvfTE1F7Wa3P2do1o+149kSdGkjyVYt6e4r2r5UQZ6ocA@mail.gmail.com>
 <1680588670.6153247-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEtTFk40ShdgyAJeBrUphZnMgk-RE0RpcHyc1uvSNoXAOA@mail.gmail.com>
 <1680590673.0168557-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEt=dO+G89v+G8goOtgOHpzKdw_bUuL-o7u1g6tsP=bfJQ@mail.gmail.com>
In-Reply-To: <CACGkMEt=dO+G89v+G8goOtgOHpzKdw_bUuL-o7u1g6tsP=bfJQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-8.0 required=5.0 tests=ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 4 Apr 2023 15:01:36 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Tue, Apr 4, 2023 at 2:55=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.=
com> wrote:
> >
> > On Tue, 4 Apr 2023 14:35:05 +0800, Jason Wang <jasowang@redhat.com> wro=
te:
> > > On Tue, Apr 4, 2023 at 2:22=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alib=
aba.com> wrote:
> > > >
> > > > On Tue, 4 Apr 2023 13:04:02 +0800, Jason Wang <jasowang@redhat.com>=
 wrote:
> > > > > On Mon, Apr 3, 2023 at 12:17=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux=
.alibaba.com> wrote:
> > > > > >
> > > > > > On Mon, 3 Apr 2023 10:43:03 +0800, Jason Wang <jasowang@redhat.=
com> wrote:
> > > > > > > On Tue, Mar 28, 2023 at 8:04=E2=80=AFPM Xuan Zhuo <xuanzhuo@l=
inux.alibaba.com> wrote:
> > > > > > > >
> > > > > > > > At present, we have two similar logic to perform the XDP pr=
og.
> > > > > > > >
> > > > > > > > Therefore, this PATCH separates the code of executing XDP, =
which is
> > > > > > > > conducive to later maintenance.
> > > > > > > >
> > > > > > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > > > > > ---
> > > > > > > >  drivers/net/virtio_net.c | 142 +++++++++++++++++++++------=
------------
> > > > > > > >  1 file changed, 75 insertions(+), 67 deletions(-)
> > > > > > > >
> > > > > > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_=
net.c
> > > > > > > > index bb426958cdd4..72b9d6ee4024 100644
> > > > > > > > --- a/drivers/net/virtio_net.c
> > > > > > > > +++ b/drivers/net/virtio_net.c
> > > > > > > > @@ -301,6 +301,15 @@ struct padded_vnet_hdr {
> > > > > > > >         char padding[12];
> > > > > > > >  };
> > > > > > > >
> > > > > > > > +enum {
> > > > > > > > +       /* xdp pass */
> > > > > > > > +       VIRTNET_XDP_RES_PASS,
> > > > > > > > +       /* drop packet. the caller needs to release the pag=
e. */
> > > > > > > > +       VIRTNET_XDP_RES_DROP,
> > > > > > > > +       /* packet is consumed by xdp. the caller needs to d=
o nothing. */
> > > > > > > > +       VIRTNET_XDP_RES_CONSUMED,
> > > > > > > > +};
> > > > > > >
> > > > > > > I'd prefer this to be done on top unless it is a must. But I =
don't see
> > > > > > > any advantage of introducing this, it's partial mapping of XD=
P action
> > > > > > > and it needs to be extended when XDP action is extended. (And=
 we've
> > > > > > > already had: VIRTIO_XDP_REDIR and VIRTIO_XDP_TX ...)
> > > > > >
> > > > > > No, these are the three states of buffer after XDP processing.
> > > > > >
> > > > > > * PASS: goto make skb
> > > > >
> > > > > XDP_PASS goes for this.
> > > > >
> > > > > > * DROP: we should release buffer
> > > > >
> > > > > XDP_DROP and error conditions go with this.
> > > > >
> > > > > > * CUNSUMED: xdp prog used the buffer, we do nothing
> > > > >
> > > > > XDP_TX/XDP_REDIRECTION goes for this.
> > > > >
> > > > > So t virtnet_xdp_handler() just maps XDP ACTION plus the error
> > > > > conditions to the above three states.
> > > > >
> > > > > We can simply map error to XDP_DROP like:
> > > > >
> > > > >        case XDP_TX:
> > > > >               stats->xdp_tx++;
> > > > >                xdpf =3D xdp_convert_buff_to_frame(xdp);
> > > > >                if (unlikely(!xdpf))
> > > > >                        return XDP_DROP;
> > > > >
> > > > > A good side effect is to avoid the xdp_xmit pointer to be passed =
to
> > > > > the function.
> > > >
> > > >
> > > > So, I guess you mean this:
> > > >
> > > >         switch (act) {
> > > >         case XDP_PASS:
> > > >                 /* handle pass */
> > > >                 return skb;
> > > >
> > > >         case XDP_TX:
> > > >                 *xdp_xmit |=3D VIRTIO_XDP_TX;
> > > >                 goto xmit;
> > > >
> > > >         case XDP_REDIRECT:
> > > >                 *xdp_xmit |=3D VIRTIO_XDP_REDIR;
> > > >                 goto xmit;
> > > >
> > > >         case XDP_DROP:
> > > >         default:
> > > >                 goto err_xdp;
> > > >         }
> > > >
> > > > I have to say there is no problem from the perspective of code impl=
ementation.
> > >
> > > Note that this is the current logic where it is determined in
> > > receive_small() and receive_mergeable().
> >
> > Yes, but the purpose of this patches is to simplify the call.
>
> You mean simplify the receive_small()/mergeable()?

YES.


>
> >
> > >
> > > >
> > > > But if the a new ACTION liking XDP_TX,XDP_REDIRECT is added in the =
future, then
> > > > we must modify all the callers.
> > >
> > > This is fine since we only use a single type for XDP action.
> >
> > a single type?
>
> Instead of (partial) duplicating XDP actions in the new enums.


I think it's really misunderstand here. So your thought is these?

   VIRTNET_XDP_RES_PASS,
   VIRTNET_XDP_RES_TX_REDIRECT,
   VIRTNET_XDP_RES_DROP,



>
> >
> > >
> > > > This is the benefit of using CUNSUMED.
> > >
> > > It's very hard to say, e.g if we want to support cloning in the futur=
e.
> >
> > cloning? You mean clone one new buffer.
> >
> > It is true that no matter what realization, the logic must be modified.
>
> Yes.
>
> >
> > >
> > > >
> > > > I think it is a good advantage to put xdp_xmit in virtnet_xdp_handl=
er(),
> > > > which makes the caller not care too much about these details.
> > >
> > > This part I don't understand, having xdp_xmit means the caller need to
> > > know whether it is xmited or redirected. The point of the enum is to
> > > hide the XDP actions, but it's conflict with what xdp_xmit who want to
> > > expose (part of) the XDP actions.
> >
> > I mean, no matter what virtnet_xdp_handler () returns? XDP_ACTION or so=
me one I
> > defined, I want to hide the modification of xdp_xmit to virtnet_xdp_han=
dler().
> >
> > Even if virtnet_xdp_handler() returns XDP_TX, we can also complete the
> > modification of XDP_XMIT within Virtnet_xdp_handler().
> >
> >
> > >
> > > > If you take into
> > > > account the problem of increasing the number of parameters, I advis=
e to put it
> > > > in rq.
> > >
> > > I don't have strong opinion to introduce the enum,
> >
> > OK, I will drop these new enums.
>
> Just to make sure we are at the same page. I mean, if there is no
> objection from others, I'm ok to have an enum, but we need to use a
> separate patch to do that.

Do you refer to introduce enums alone without virtnet_xdp_handler()?

>
> >
> > > what I want to say
> > > is, use a separated patch to do that.
> >
> > Does this part refer to putting xdp_xmit in rq?
>
> I mean it's better to be done separately. But I don't see the
> advantage of this other than reducing the parameters.

I think so also.

Thanks.


>
> Thanks
>
> >
> > Thanks.
> >
> >
> > >
> > > Thanks
> > >
> > > >
> > > > Thanks.
> > > >
> > > >
> > > >
> > > > >
> > > > > >
> > > > > > The latter two are not particularly related to XDP ACTION. And =
it does not need
> > > > > > to extend when XDP action is extended. At least I have not thou=
ght of this
> > > > > > situation.
> > > > >
> > > > > What's the advantages of such indirection compared to using XDP a=
ction directly?
> > > > >
> > > > > Thanks
> > > > >
> > > > > >
> > > > > >
> > > > > > >
> > > > > > > > +
> > > > > > > >  static void virtnet_rq_free_unused_buf(struct virtqueue *v=
q, void *buf);
> > > > > > > >  static void virtnet_sq_free_unused_buf(struct virtqueue *v=
q, void *buf);
> > > > > > > >
> > > > > > > > @@ -789,6 +798,59 @@ static int virtnet_xdp_xmit(struct net=
_device *dev,
> > > > > > > >         return ret;
> > > > > > > >  }
> > > > > > > >
> > > > > > > > +static int virtnet_xdp_handler(struct bpf_prog *xdp_prog, =
struct xdp_buff *xdp,
> > > > > > > > +                              struct net_device *dev,
> > > > > > > > +                              unsigned int *xdp_xmit,
> > > > > > > > +                              struct virtnet_rq_stats *sta=
ts)
> > > > > > > > +{
> > > > > > > > +       struct xdp_frame *xdpf;
> > > > > > > > +       int err;
> > > > > > > > +       u32 act;
> > > > > > > > +
> > > > > > > > +       act =3D bpf_prog_run_xdp(xdp_prog, xdp);
> > > > > > > > +       stats->xdp_packets++;
> > > > > > > > +
> > > > > > > > +       switch (act) {
> > > > > > > > +       case XDP_PASS:
> > > > > > > > +               return VIRTNET_XDP_RES_PASS;
> > > > > > > > +
> > > > > > > > +       case XDP_TX:
> > > > > > > > +               stats->xdp_tx++;
> > > > > > > > +               xdpf =3D xdp_convert_buff_to_frame(xdp);
> > > > > > > > +               if (unlikely(!xdpf))
> > > > > > > > +                       return VIRTNET_XDP_RES_DROP;
> > > > > > > > +
> > > > > > > > +               err =3D virtnet_xdp_xmit(dev, 1, &xdpf, 0);
> > > > > > > > +               if (unlikely(!err)) {
> > > > > > > > +                       xdp_return_frame_rx_napi(xdpf);
> > > > > > > > +               } else if (unlikely(err < 0)) {
> > > > > > > > +                       trace_xdp_exception(dev, xdp_prog, =
act);
> > > > > > > > +                       return VIRTNET_XDP_RES_DROP;
> > > > > > > > +               }
> > > > > > > > +
> > > > > > > > +               *xdp_xmit |=3D VIRTIO_XDP_TX;
> > > > > > > > +               return VIRTNET_XDP_RES_CONSUMED;
> > > > > > > > +
> > > > > > > > +       case XDP_REDIRECT:
> > > > > > > > +               stats->xdp_redirects++;
> > > > > > > > +               err =3D xdp_do_redirect(dev, xdp, xdp_prog);
> > > > > > > > +               if (err)
> > > > > > > > +                       return VIRTNET_XDP_RES_DROP;
> > > > > > > > +
> > > > > > > > +               *xdp_xmit |=3D VIRTIO_XDP_REDIR;
> > > > > > > > +               return VIRTNET_XDP_RES_CONSUMED;
> > > > > > > > +
> > > > > > > > +       default:
> > > > > > > > +               bpf_warn_invalid_xdp_action(dev, xdp_prog, =
act);
> > > > > > > > +               fallthrough;
> > > > > > > > +       case XDP_ABORTED:
> > > > > > > > +               trace_xdp_exception(dev, xdp_prog, act);
> > > > > > > > +               fallthrough;
> > > > > > > > +       case XDP_DROP:
> > > > > > > > +               return VIRTNET_XDP_RES_DROP;
> > > > > > > > +       }
> > > > > > > > +}
> > > > > > > > +
> > > > > > > >  static unsigned int virtnet_get_headroom(struct virtnet_in=
fo *vi)
> > > > > > > >  {
> > > > > > > >         return vi->xdp_enabled ? VIRTIO_XDP_HEADROOM : 0;
> > > > > > > > @@ -876,7 +938,6 @@ static struct sk_buff *receive_small(st=
ruct net_device *dev,
> > > > > > > >         struct page *page =3D virt_to_head_page(buf);
> > > > > > > >         unsigned int delta =3D 0;
> > > > > > > >         struct page *xdp_page;
> > > > > > > > -       int err;
> > > > > > > >         unsigned int metasize =3D 0;
> > > > > > > >
> > > > > > > >         len -=3D vi->hdr_len;
> > > > > > > > @@ -898,7 +959,6 @@ static struct sk_buff *receive_small(st=
ruct net_device *dev,
> > > > > > > >         xdp_prog =3D rcu_dereference(rq->xdp_prog);
> > > > > > > >         if (xdp_prog) {
> > > > > > > >                 struct virtio_net_hdr_mrg_rxbuf *hdr =3D bu=
f + header_offset;
> > > > > > > > -               struct xdp_frame *xdpf;
> > > > > > > >                 struct xdp_buff xdp;
> > > > > > > >                 void *orig_data;
> > > > > > > >                 u32 act;
> > > > > > > > @@ -931,46 +991,22 @@ static struct sk_buff *receive_small(=
struct net_device *dev,
> > > > > > > >                 xdp_prepare_buff(&xdp, buf + VIRTNET_RX_PAD=
 + vi->hdr_len,
> > > > > > > >                                  xdp_headroom, len, true);
> > > > > > > >                 orig_data =3D xdp.data;
> > > > > > > > -               act =3D bpf_prog_run_xdp(xdp_prog, &xdp);
> > > > > > > > -               stats->xdp_packets++;
> > > > > > > > +
> > > > > > > > +               act =3D virtnet_xdp_handler(xdp_prog, &xdp,=
 dev, xdp_xmit, stats);
> > > > > > > >
> > > > > > > >                 switch (act) {
> > > > > > > > -               case XDP_PASS:
> > > > > > > > +               case VIRTNET_XDP_RES_PASS:
> > > > > > > >                         /* Recalculate length in case bpf p=
rogram changed it */
> > > > > > > >                         delta =3D orig_data - xdp.data;
> > > > > > > >                         len =3D xdp.data_end - xdp.data;
> > > > > > > >                         metasize =3D xdp.data - xdp.data_me=
ta;
> > > > > > > >                         break;
> > > > > > > > -               case XDP_TX:
> > > > > > > > -                       stats->xdp_tx++;
> > > > > > > > -                       xdpf =3D xdp_convert_buff_to_frame(=
&xdp);
> > > > > > > > -                       if (unlikely(!xdpf))
> > > > > > > > -                               goto err_xdp;
> > > > > > > > -                       err =3D virtnet_xdp_xmit(dev, 1, &x=
dpf, 0);
> > > > > > > > -                       if (unlikely(!err)) {
> > > > > > > > -                               xdp_return_frame_rx_napi(xd=
pf);
> > > > > > > > -                       } else if (unlikely(err < 0)) {
> > > > > > > > -                               trace_xdp_exception(vi->dev=
, xdp_prog, act);
> > > > > > > > -                               goto err_xdp;
> > > > > > > > -                       }
> > > > > > > > -                       *xdp_xmit |=3D VIRTIO_XDP_TX;
> > > > > > > > -                       rcu_read_unlock();
> > > > > > > > -                       goto xdp_xmit;
> > > > > > > > -               case XDP_REDIRECT:
> > > > > > > > -                       stats->xdp_redirects++;
> > > > > > > > -                       err =3D xdp_do_redirect(dev, &xdp, =
xdp_prog);
> > > > > > > > -                       if (err)
> > > > > > > > -                               goto err_xdp;
> > > > > > > > -                       *xdp_xmit |=3D VIRTIO_XDP_REDIR;
> > > > > > > > +
> > > > > > > > +               case VIRTNET_XDP_RES_CONSUMED:
> > > > > > > >                         rcu_read_unlock();
> > > > > > > >                         goto xdp_xmit;
> > > > > > > > -               default:
> > > > > > > > -                       bpf_warn_invalid_xdp_action(vi->dev=
, xdp_prog, act);
> > > > > > > > -                       fallthrough;
> > > > > > > > -               case XDP_ABORTED:
> > > > > > > > -                       trace_xdp_exception(vi->dev, xdp_pr=
og, act);
> > > > > > > > -                       goto err_xdp;
> > > > > > > > -               case XDP_DROP:
> > > > > > > > +
> > > > > > > > +               case VIRTNET_XDP_RES_DROP:
> > > > > > > >                         goto err_xdp;
> > > > > > > >                 }
> > > > > > > >         }
> > > > > > > > @@ -1277,7 +1313,6 @@ static struct sk_buff *receive_mergea=
ble(struct net_device *dev,
> > > > > > > >         if (xdp_prog) {
> > > > > > > >                 unsigned int xdp_frags_truesz =3D 0;
> > > > > > > >                 struct skb_shared_info *shinfo;
> > > > > > > > -               struct xdp_frame *xdpf;
> > > > > > > >                 struct page *xdp_page;
> > > > > > > >                 struct xdp_buff xdp;
> > > > > > > >                 void *data;
> > > > > > > > @@ -1294,49 +1329,22 @@ static struct sk_buff *receive_merg=
eable(struct net_device *dev,
> > > > > > > >                 if (unlikely(err))
> > > > > > > >                         goto err_xdp_frags;
> > > > > > > >
> > > > > > > > -               act =3D bpf_prog_run_xdp(xdp_prog, &xdp);
> > > > > > > > -               stats->xdp_packets++;
> > > > > > > > +               act =3D virtnet_xdp_handler(xdp_prog, &xdp,=
 dev, xdp_xmit, stats);
> > > > > > > >
> > > > > > > >                 switch (act) {
> > > > > > > > -               case XDP_PASS:
> > > > > > > > +               case VIRTNET_XDP_RES_PASS:
> > > > > > > >                         head_skb =3D build_skb_from_xdp_buf=
f(dev, vi, &xdp, xdp_frags_truesz);
> > > > > > > >                         if (unlikely(!head_skb))
> > > > > > > >                                 goto err_xdp_frags;
> > > > > > > >
> > > > > > > >                         rcu_read_unlock();
> > > > > > > >                         return head_skb;
> > > > > > > > -               case XDP_TX:
> > > > > > > > -                       stats->xdp_tx++;
> > > > > > > > -                       xdpf =3D xdp_convert_buff_to_frame(=
&xdp);
> > > > > > > > -                       if (unlikely(!xdpf)) {
> > > > > > > > -                               netdev_dbg(dev, "convert bu=
ff to frame failed for xdp\n");
> > > > > > >
> > > > > > > Nit: This debug is lost after the conversion.
> > > > > >
> > > > > > Will fix.
> > > > > >
> > > > > > Thanks.
> > > > > >
> > > > > > >
> > > > > > > Thanks
> > > > > > >
> > > > > > > > -                               goto err_xdp_frags;
> > > > > > > > -                       }
> > > > > > > > -                       err =3D virtnet_xdp_xmit(dev, 1, &x=
dpf, 0);
> > > > > > > > -                       if (unlikely(!err)) {
> > > > > > > > -                               xdp_return_frame_rx_napi(xd=
pf);
> > > > > > > > -                       } else if (unlikely(err < 0)) {
> > > > > > > > -                               trace_xdp_exception(vi->dev=
, xdp_prog, act);
> > > > > > > > -                               goto err_xdp_frags;
> > > > > > > > -                       }
> > > > > > > > -                       *xdp_xmit |=3D VIRTIO_XDP_TX;
> > > > > > > > -                       rcu_read_unlock();
> > > > > > > > -                       goto xdp_xmit;
> > > > > > > > -               case XDP_REDIRECT:
> > > > > > > > -                       stats->xdp_redirects++;
> > > > > > > > -                       err =3D xdp_do_redirect(dev, &xdp, =
xdp_prog);
> > > > > > > > -                       if (err)
> > > > > > > > -                               goto err_xdp_frags;
> > > > > > > > -                       *xdp_xmit |=3D VIRTIO_XDP_REDIR;
> > > > > > > > +
> > > > > > > > +               case VIRTNET_XDP_RES_CONSUMED:
> > > > > > > >                         rcu_read_unlock();
> > > > > > > >                         goto xdp_xmit;
> > > > > > > > -               default:
> > > > > > > > -                       bpf_warn_invalid_xdp_action(vi->dev=
, xdp_prog, act);
> > > > > > > > -                       fallthrough;
> > > > > > > > -               case XDP_ABORTED:
> > > > > > > > -                       trace_xdp_exception(vi->dev, xdp_pr=
og, act);
> > > > > > > > -                       fallthrough;
> > > > > > > > -               case XDP_DROP:
> > > > > > > > +
> > > > > > > > +               case VIRTNET_XDP_RES_DROP:
> > > > > > > >                         goto err_xdp_frags;
> > > > > > > >                 }
> > > > > > > >  err_xdp_frags:
> > > > > > > > --
> > > > > > > > 2.32.0.3.g01195cf9f
> > > > > > > >
> > > > > > >
> > > > > >
> > > > >
> > > >
> > >
> >
>
