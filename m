Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 414A168D37E
	for <lists+bpf@lfdr.de>; Tue,  7 Feb 2023 11:05:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbjBGKFc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Feb 2023 05:05:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjBGKFb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Feb 2023 05:05:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F01AEE0;
        Tue,  7 Feb 2023 02:05:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 737976125D;
        Tue,  7 Feb 2023 10:05:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CF74C433EF;
        Tue,  7 Feb 2023 10:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675764326;
        bh=BV8dhYfQDzSO7xqTiCbH8hcMqykBClh8Zs60nZuDHQo=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=GJG6vtwRL6kG+AOhLYl2QAsUbUzJipICyLFoy9Bjz1Zq7I6tchkxG1NV2ZefxYui8
         h1gdDHf7Lzf2K2Tfdr97QqA+3Q85lcSRRB23csFyMHGbBJRmtmezm6XjC8V4bAylwB
         /ccdMW1pMLTe5hcpgnxzjxh0DQnQzwugHaZijC007YmI8OD41teOZYlMqYizcbxNyT
         X8BdH+WzCURqObnbUtaxAJn366okKa+DmA2RujYTnycMcmh2JS/hJWD4GdWbK7KG3L
         tZJ41BoiSHlIwErh3ea0nFUvjtItO/CFsexUhktf7azJafKSPtav0KcEnxhSmfE0Fx
         6TTeLlhJ8Kphg==
Date:   Tue, 7 Feb 2023 11:05:23 +0100
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     bpf@vger.kernel.org, netdev@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, davem@davemloft.net,
        kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
        hawk@kernel.org, toke@redhat.com, memxor@gmail.com,
        alardam@gmail.com, saeedm@nvidia.com, anthony.l.nguyen@intel.com,
        gospo@broadcom.com, vladimir.oltean@nxp.com, nbd@nbd.name,
        john@phrozen.org, leon@kernel.org, simon.horman@corigine.com,
        aelior@marvell.com, christophe.jaillet@wanadoo.fr,
        ecree.xilinx@gmail.com, mst@redhat.com, bjorn@kernel.org,
        magnus.karlsson@intel.com, maciej.fijalkowski@intel.com,
        intel-wired-lan@lists.osuosl.org, lorenzo.bianconi@redhat.com,
        martin.lau@linux.dev, sdf@google.com, gerhard@engleder-embedded.com
Subject: Re: [PATCH v5 bpf-next 2/8] drivers: net: turn on XDP features
Message-ID: <Y+IiY5e1aoJGdmRT@lore-desk>
References: <cover.1675245257.git.lorenzo@kernel.org>
 <3eca9fafb308462f7edb1f58e451d59209aa07eb.1675245258.git.lorenzo@kernel.org>
 <Y+ISeJFWIHnBEx5n@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="TAZHCJTWsWnAkEmY"
Content-Disposition: inline
In-Reply-To: <Y+ISeJFWIHnBEx5n@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


--TAZHCJTWsWnAkEmY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Wed, Feb 01, 2023 at 11:24:18AM +0100, Lorenzo Bianconi wrote:
> > From: Marek Majtyka <alardam@gmail.com>
> >=20
> > A summary of the flags being set for various drivers is given below.
> > Note that XDP_F_REDIRECT_TARGET and XDP_F_FRAG_TARGET are features
> > that can be turned off and on at runtime. This means that these flags
> > may be set and unset under RTNL lock protection by the driver. Hence,
> > READ_ONCE must be used by code loading the flag value.
> >=20
> > Also, these flags are not used for synchronization against the availabi=
lity
> > of XDP resources on a device. It is merely a hint, and hence the read
> > may race with the actual teardown of XDP resources on the device. This
> > may change in the future, e.g. operations taking a reference on the XDP
> > resources of the driver, and in turn inhibiting turning off this flag.
> > However, for now, it can only be used as a hint to check whether device
> > supports becoming a redirection target.
> >=20
> > Turn 'hw-offload' feature flag on for:
> >  - netronome (nfp)
> >  - netdevsim.
> >=20
> > Turn 'native' and 'zerocopy' features flags on for:
> >  - intel (i40e, ice, ixgbe, igc)
> >  - mellanox (mlx5).
> >  - stmmac
> >  - netronome (nfp)
> >=20
> > Turn 'native' features flags on for:
> >  - amazon (ena)
> >  - broadcom (bnxt)
> >  - freescale (dpaa, dpaa2, enetc)
> >  - funeth
> >  - intel (igb)
> >  - marvell (mvneta, mvpp2, octeontx2)
> >  - mellanox (mlx4)
> >  - mtk_eth_soc
> >  - qlogic (qede)
> >  - sfc
> >  - socionext (netsec)
> >  - ti (cpsw)
> >  - tap
> >  - tsnep
> >  - veth
> >  - xen
> >  - virtio_net.
> >=20
> > Turn 'basic' (tx, pass, aborted and drop) features flags on for:
> >  - netronome (nfp)
> >  - cavium (thunder)
> >  - hyperv.
> >=20
> > Turn 'redirect_target' feature flag on for:
> >  - amanzon (ena)
> >  - broadcom (bnxt)
> >  - freescale (dpaa, dpaa2)
> >  - intel (i40e, ice, igb, ixgbe)
> >  - ti (cpsw)
> >  - marvell (mvneta, mvpp2)
> >  - sfc
> >  - socionext (netsec)
> >  - qlogic (qede)
> >  - mellanox (mlx5)
> >  - tap
> >  - veth
> >  - virtio_net
> >  - xen
> >=20
> > Reviewed-by: Gerhard Engleder <gerhard@engleder-embedded.com>
> > Reviewed-by: Simon Horman <simon.horman@corigine.com>
> > Acked-by: Stanislav Fomichev <sdf@google.com>
> > Acked-by: Jakub Kicinski <kuba@kernel.org>
> > Co-developed-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > Signed-off-by: Marek Majtyka <alardam@gmail.com>
> > ---
> >  drivers/net/ethernet/amazon/ena/ena_netdev.c   |  4 ++++
> >  .../net/ethernet/aquantia/atlantic/aq_nic.c    |  5 +++++
> >  drivers/net/ethernet/broadcom/bnxt/bnxt.c      |  3 +++
> >  drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c  |  2 ++
> >  .../net/ethernet/cavium/thunder/nicvf_main.c   |  2 ++
> >  drivers/net/ethernet/engleder/tsnep_main.c     |  4 ++++
> >  drivers/net/ethernet/freescale/dpaa/dpaa_eth.c |  4 ++++
> >  .../net/ethernet/freescale/dpaa2/dpaa2-eth.c   |  4 ++++
> >  .../net/ethernet/freescale/enetc/enetc_pf.c    |  3 +++
> >  .../net/ethernet/fungible/funeth/funeth_main.c |  6 ++++++
> >  drivers/net/ethernet/intel/i40e/i40e_main.c    | 10 ++++++++--
> >  drivers/net/ethernet/intel/ice/ice_main.c      |  5 +++++
> >  drivers/net/ethernet/intel/igb/igb_main.c      |  9 ++++++++-
> >  drivers/net/ethernet/intel/igc/igc_main.c      |  3 +++
> >  drivers/net/ethernet/intel/igc/igc_xdp.c       |  5 +++++
> >  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c  |  6 ++++++
> >  .../net/ethernet/intel/ixgbevf/ixgbevf_main.c  |  1 +
> >  drivers/net/ethernet/marvell/mvneta.c          |  3 +++
> >  .../net/ethernet/marvell/mvpp2/mvpp2_main.c    |  4 ++++
> >  .../ethernet/marvell/octeontx2/nic/otx2_pf.c   |  8 ++++++--
> >  drivers/net/ethernet/mediatek/mtk_eth_soc.c    |  6 ++++++
> >  drivers/net/ethernet/mellanox/mlx4/en_netdev.c |  2 ++
> >  .../net/ethernet/mellanox/mlx5/core/en_main.c  | 11 +++++++++++
> >  drivers/net/ethernet/microsoft/mana/mana_en.c  |  2 ++
> >  .../ethernet/netronome/nfp/nfp_net_common.c    |  5 +++++
> >  drivers/net/ethernet/qlogic/qede/qede_main.c   |  3 +++
> >  drivers/net/ethernet/sfc/efx.c                 |  4 ++++
> >  drivers/net/ethernet/sfc/siena/efx.c           |  4 ++++
> >  drivers/net/ethernet/socionext/netsec.c        |  3 +++
> >  .../net/ethernet/stmicro/stmmac/stmmac_main.c  |  2 ++
> >  drivers/net/ethernet/ti/cpsw.c                 |  4 ++++
> >  drivers/net/ethernet/ti/cpsw_new.c             |  4 ++++
> >  drivers/net/hyperv/netvsc_drv.c                |  2 ++
> >  drivers/net/netdevsim/netdev.c                 |  1 +
> >  drivers/net/tun.c                              |  5 +++++
> >  drivers/net/veth.c                             |  4 ++++
> >  drivers/net/virtio_net.c                       |  4 ++++
> >  drivers/net/xen-netfront.c                     |  2 ++
> >  include/net/xdp.h                              | 12 ++++++++++++
> >  net/core/xdp.c                                 | 18 ++++++++++++++++++
> >  40 files changed, 184 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net=
/ethernet/amazon/ena/ena_netdev.c
> > index e8ad5ea31aff..d3999db7c6a2 100644
> > --- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
> > +++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
> > @@ -597,7 +597,9 @@ static int ena_xdp_set(struct net_device *netdev, s=
truct netdev_bpf *bpf)
> >  				if (rc)
> >  					return rc;
> >  			}
> > +			xdp_features_set_redirect_target(netdev, false);
> >  		} else if (old_bpf_prog) {
> > +			xdp_features_clear_redirect_target(netdev);
> >  			rc =3D ena_destroy_and_free_all_xdp_queues(adapter);
> >  			if (rc)
> >  				return rc;
> > @@ -4103,6 +4105,8 @@ static void ena_set_conf_feat_params(struct ena_a=
dapter *adapter,
> >  	/* Set offload features */
> >  	ena_set_dev_offloads(feat, netdev);
> > =20
> > +	netdev->xdp_features =3D NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRE=
CT;
> > +
> >  	adapter->max_mtu =3D feat->dev_attr.max_mtu;
> >  	netdev->max_mtu =3D adapter->max_mtu;
> >  	netdev->min_mtu =3D ENA_MIN_MTU;
> > diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_nic.c b/drivers/=
net/ethernet/aquantia/atlantic/aq_nic.c
> > index 06508eebb585..d6d6d5d37ff3 100644
> > --- a/drivers/net/ethernet/aquantia/atlantic/aq_nic.c
> > +++ b/drivers/net/ethernet/aquantia/atlantic/aq_nic.c
> > @@ -384,6 +384,11 @@ void aq_nic_ndev_init(struct aq_nic_s *self)
> >  	self->ndev->mtu =3D aq_nic_cfg->mtu - ETH_HLEN;
> >  	self->ndev->max_mtu =3D aq_hw_caps->mtu - ETH_FCS_LEN - ETH_HLEN;
> > =20
> > +	self->ndev->xdp_features =3D NETDEV_XDP_ACT_BASIC |
> > +				   NETDEV_XDP_ACT_REDIRECT |
> > +				   NETDEV_XDP_ACT_NDO_XMIT |
> > +				   NETDEV_XDP_ACT_RX_SG |
> > +				   NETDEV_XDP_ACT_NDO_XMIT_SG;
> >  }
> > =20
> >  void aq_nic_set_tx_ring(struct aq_nic_s *self, unsigned int idx,
> > diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/et=
hernet/broadcom/bnxt/bnxt.c
> > index 240a7e8a7652..a1b4356dfb6c 100644
> > --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> > +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> > @@ -13686,6 +13686,9 @@ static int bnxt_init_one(struct pci_dev *pdev, =
const struct pci_device_id *ent)
> > =20
> >  	netif_set_tso_max_size(dev, GSO_MAX_SIZE);
> > =20
> > +	dev->xdp_features =3D NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT |
> > +			    NETDEV_XDP_ACT_RX_SG;
> > +
> >  #ifdef CONFIG_BNXT_SRIOV
> >  	init_waitqueue_head(&bp->sriov_cfg_wait);
> >  #endif
> > diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c b/drivers/ne=
t/ethernet/broadcom/bnxt/bnxt_xdp.c
> > index 36d5202c0aee..5843c93b1711 100644
> > --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
> > +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
> > @@ -422,9 +422,11 @@ static int bnxt_xdp_set(struct bnxt *bp, struct bp=
f_prog *prog)
> > =20
> >  	if (prog) {
> >  		bnxt_set_rx_skb_mode(bp, true);
> > +		xdp_features_set_redirect_target(dev, true);
> >  	} else {
> >  		int rx, tx;
> > =20
> > +		xdp_features_clear_redirect_target(dev);
> >  		bnxt_set_rx_skb_mode(bp, false);
> >  		bnxt_get_max_rings(bp, &rx, &tx, true);
> >  		if (rx > 1) {
> > diff --git a/drivers/net/ethernet/cavium/thunder/nicvf_main.c b/drivers=
/net/ethernet/cavium/thunder/nicvf_main.c
> > index f2f95493ec89..8b25313c7f6b 100644
> > --- a/drivers/net/ethernet/cavium/thunder/nicvf_main.c
> > +++ b/drivers/net/ethernet/cavium/thunder/nicvf_main.c
> > @@ -2218,6 +2218,8 @@ static int nicvf_probe(struct pci_dev *pdev, cons=
t struct pci_device_id *ent)
> >  	netdev->netdev_ops =3D &nicvf_netdev_ops;
> >  	netdev->watchdog_timeo =3D NICVF_TX_TIMEOUT;
> > =20
> > +	netdev->xdp_features =3D NETDEV_XDP_ACT_BASIC;
> > +
> >  	/* MTU range: 64 - 9200 */
> >  	netdev->min_mtu =3D NIC_HW_MIN_FRS;
> >  	netdev->max_mtu =3D NIC_HW_MAX_FRS;
> > diff --git a/drivers/net/ethernet/engleder/tsnep_main.c b/drivers/net/e=
thernet/engleder/tsnep_main.c
> > index c3cf427a9409..6982aaa928b5 100644
> > --- a/drivers/net/ethernet/engleder/tsnep_main.c
> > +++ b/drivers/net/ethernet/engleder/tsnep_main.c
> > @@ -1926,6 +1926,10 @@ static int tsnep_probe(struct platform_device *p=
dev)
> >  	netdev->features =3D NETIF_F_SG;
> >  	netdev->hw_features =3D netdev->features | NETIF_F_LOOPBACK;
> > =20
> > +	netdev->xdp_features =3D NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRE=
CT |
> > +			       NETDEV_XDP_ACT_NDO_XMIT |
> > +			       NETDEV_XDP_ACT_NDO_XMIT_SG;
> > +
> >  	/* carrier off reporting is important to ethtool even BEFORE open */
> >  	netif_carrier_off(netdev);
> > =20
> > diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c b/drivers/n=
et/ethernet/freescale/dpaa/dpaa_eth.c
> > index 027fff9f7db0..9318a2554056 100644
> > --- a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
> > +++ b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
> > @@ -244,6 +244,10 @@ static int dpaa_netdev_init(struct net_device *net=
_dev,
> >  	net_dev->features |=3D net_dev->hw_features;
> >  	net_dev->vlan_features =3D net_dev->features;
> > =20
> > +	net_dev->xdp_features =3D NETDEV_XDP_ACT_BASIC |
> > +				NETDEV_XDP_ACT_REDIRECT |
> > +				NETDEV_XDP_ACT_NDO_XMIT;
> > +
> >  	if (is_valid_ether_addr(mac_addr)) {
> >  		memcpy(net_dev->perm_addr, mac_addr, net_dev->addr_len);
> >  		eth_hw_addr_set(net_dev, mac_addr);
> > diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c b/drivers=
/net/ethernet/freescale/dpaa2/dpaa2-eth.c
> > index 2e79d18fc3c7..746ccfde7255 100644
> > --- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
> > +++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
> > @@ -4596,6 +4596,10 @@ static int dpaa2_eth_netdev_init(struct net_devi=
ce *net_dev)
> >  			    NETIF_F_LLTX | NETIF_F_HW_TC | NETIF_F_TSO;
> >  	net_dev->gso_max_segs =3D DPAA2_ETH_ENQUEUE_MAX_FDS;
> >  	net_dev->hw_features =3D net_dev->features;
> > +	net_dev->xdp_features =3D NETDEV_XDP_ACT_BASIC |
> > +				NETDEV_XDP_ACT_REDIRECT |
> > +				NETDEV_XDP_ACT_XSK_ZEROCOPY |
> > +				NETDEV_XDP_ACT_NDO_XMIT;
> > =20
> >  	if (priv->dpni_attrs.vlan_filter_entries)
> >  		net_dev->hw_features |=3D NETIF_F_HW_VLAN_CTAG_FILTER;
> > diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.c b/drivers/=
net/ethernet/freescale/enetc/enetc_pf.c
> > index 7facc7d5261e..6b54071d4ecc 100644
> > --- a/drivers/net/ethernet/freescale/enetc/enetc_pf.c
> > +++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
> > @@ -807,6 +807,9 @@ static void enetc_pf_netdev_setup(struct enetc_si *=
si, struct net_device *ndev,
> >  		ndev->hw_features |=3D NETIF_F_RXHASH;
> > =20
> >  	ndev->priv_flags |=3D IFF_UNICAST_FLT;
> > +	ndev->xdp_features =3D NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT=
 |
> > +			     NETDEV_XDP_ACT_NDO_XMIT | NETDEV_XDP_ACT_RX_SG |
> > +			     NETDEV_XDP_ACT_NDO_XMIT_SG;
> > =20
> >  	if (si->hw_features & ENETC_SI_F_PSFP && !enetc_psfp_enable(priv)) {
> >  		priv->active_offloads |=3D ENETC_F_QCI;
> > diff --git a/drivers/net/ethernet/fungible/funeth/funeth_main.c b/drive=
rs/net/ethernet/fungible/funeth/funeth_main.c
> > index b4cce30e526a..df86770731ad 100644
> > --- a/drivers/net/ethernet/fungible/funeth/funeth_main.c
> > +++ b/drivers/net/ethernet/fungible/funeth/funeth_main.c
> > @@ -1160,6 +1160,11 @@ static int fun_xdp_setup(struct net_device *dev,=
 struct netdev_bpf *xdp)
> >  			WRITE_ONCE(rxqs[i]->xdp_prog, prog);
> >  	}
> > =20
> > +	if (prog)
> > +		xdp_features_set_redirect_target(dev, true);
> > +	else
> > +		xdp_features_clear_redirect_target(dev);
> > +
> >  	dev->max_mtu =3D prog ? XDP_MAX_MTU : FUN_MAX_MTU;
> >  	old_prog =3D xchg(&fp->xdp_prog, prog);
> >  	if (old_prog)
> > @@ -1765,6 +1770,7 @@ static int fun_create_netdev(struct fun_ethdev *e=
d, unsigned int portid)
> >  	netdev->vlan_features =3D netdev->features & VLAN_FEAT;
> >  	netdev->mpls_features =3D netdev->vlan_features;
> >  	netdev->hw_enc_features =3D netdev->hw_features;
> > +	netdev->xdp_features =3D NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRE=
CT;
> > =20
> >  	netdev->min_mtu =3D ETH_MIN_MTU;
> >  	netdev->max_mtu =3D FUN_MAX_MTU;
> > diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/=
ethernet/intel/i40e/i40e_main.c
> > index 53d0083e35da..8a79cc18c428 100644
> > --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> > +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> > @@ -13339,9 +13339,11 @@ static int i40e_xdp_setup(struct i40e_vsi *vsi=
, struct bpf_prog *prog,
> >  	old_prog =3D xchg(&vsi->xdp_prog, prog);
> > =20
> >  	if (need_reset) {
> > -		if (!prog)
> > +		if (!prog) {
> > +			xdp_features_clear_redirect_target(vsi->netdev);
> >  			/* Wait until ndo_xsk_wakeup completes. */
> >  			synchronize_rcu();
> > +		}
> >  		i40e_reset_and_rebuild(pf, true, true);
> >  	}
> > =20
> > @@ -13362,11 +13364,13 @@ static int i40e_xdp_setup(struct i40e_vsi *vs=
i, struct bpf_prog *prog,
> >  	/* Kick start the NAPI context if there is an AF_XDP socket open
> >  	 * on that queue id. This so that receiving will start.
> >  	 */
> > -	if (need_reset && prog)
> > +	if (need_reset && prog) {
> >  		for (i =3D 0; i < vsi->num_queue_pairs; i++)
> >  			if (vsi->xdp_rings[i]->xsk_pool)
> >  				(void)i40e_xsk_wakeup(vsi->netdev, i,
> >  						      XDP_WAKEUP_RX);
> > +		xdp_features_set_redirect_target(vsi->netdev, true);
> > +	}
> > =20
> >  	return 0;
> >  }
> > @@ -13783,6 +13787,8 @@ static int i40e_config_netdev(struct i40e_vsi *=
vsi)
> >  	netdev->hw_enc_features |=3D NETIF_F_TSO_MANGLEID;
> > =20
> >  	netdev->features &=3D ~NETIF_F_HW_TC;
> > +	netdev->xdp_features =3D NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRE=
CT |
> > +			       NETDEV_XDP_ACT_XSK_ZEROCOPY;
> > =20
> >  	if (vsi->type =3D=3D I40E_VSI_MAIN) {
> >  		SET_NETDEV_DEV(netdev, &pf->pdev->dev);
> > diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/et=
hernet/intel/ice/ice_main.c
> > index fce86e8ff834..26b09e4ed0c8 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_main.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> > @@ -22,6 +22,7 @@
> >  #include "ice_eswitch.h"
> >  #include "ice_tc_lib.h"
> >  #include "ice_vsi_vlan_ops.h"
> > +#include <net/xdp_sock_drv.h>
> > =20
> >  #define DRV_SUMMARY	"Intel(R) Ethernet Connection E800 Series Linux Dr=
iver"
> >  static const char ice_driver_string[] =3D DRV_SUMMARY;
> > @@ -2899,11 +2900,13 @@ ice_xdp_setup_prog(struct ice_vsi *vsi, struct =
bpf_prog *prog,
> >  			if (xdp_ring_err)
> >  				NL_SET_ERR_MSG_MOD(extack, "Setting up XDP Tx resources failed");
> >  		}
> > +		xdp_features_set_redirect_target(vsi->netdev, false);
> >  		/* reallocate Rx queues that are used for zero-copy */
> >  		xdp_ring_err =3D ice_realloc_zc_buf(vsi, true);
> >  		if (xdp_ring_err)
> >  			NL_SET_ERR_MSG_MOD(extack, "Setting up XDP Rx resources failed");
> >  	} else if (ice_is_xdp_ena_vsi(vsi) && !prog) {
> > +		xdp_features_clear_redirect_target(vsi->netdev);
> >  		xdp_ring_err =3D ice_destroy_xdp_rings(vsi);
> >  		if (xdp_ring_err)
> >  			NL_SET_ERR_MSG_MOD(extack, "Freeing XDP Tx resources failed");
> > @@ -3446,6 +3449,8 @@ static int ice_cfg_netdev(struct ice_vsi *vsi)
> >  	np->vsi =3D vsi;
> > =20
> >  	ice_set_netdev_features(netdev);
> > +	netdev->xdp_features =3D NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRE=
CT |
> > +			       NETDEV_XDP_ACT_XSK_ZEROCOPY;
> > =20
> >  	ice_set_ops(netdev);
> > =20
> > diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/et=
hernet/intel/igb/igb_main.c
> > index 3c0c35ecea10..0e11a082f7a1 100644
> > --- a/drivers/net/ethernet/intel/igb/igb_main.c
> > +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> > @@ -2871,8 +2871,14 @@ static int igb_xdp_setup(struct net_device *dev,=
 struct netdev_bpf *bpf)
> >  		bpf_prog_put(old_prog);
> > =20
> >  	/* bpf is just replaced, RXQ and MTU are already setup */
> > -	if (!need_reset)
> > +	if (!need_reset) {
> >  		return 0;
> > +	} else {
> > +		if (prog)
> > +			xdp_features_set_redirect_target(dev, true);
> > +		else
> > +			xdp_features_clear_redirect_target(dev);
> > +	}
> > =20
> >  	if (running)
> >  		igb_open(dev);
> > @@ -3317,6 +3323,7 @@ static int igb_probe(struct pci_dev *pdev, const =
struct pci_device_id *ent)
> >  	netdev->priv_flags |=3D IFF_SUPP_NOFCS;
> > =20
> >  	netdev->priv_flags |=3D IFF_UNICAST_FLT;
> > +	netdev->xdp_features =3D NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRE=
CT;
> > =20
> >  	/* MTU range: 68 - 9216 */
> >  	netdev->min_mtu =3D ETH_MIN_MTU;
> > diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/et=
hernet/intel/igc/igc_main.c
> > index e86b15efaeb8..8b572cd2c350 100644
> > --- a/drivers/net/ethernet/intel/igc/igc_main.c
> > +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> > @@ -6533,6 +6533,9 @@ static int igc_probe(struct pci_dev *pdev,
> >  	netdev->mpls_features |=3D NETIF_F_HW_CSUM;
> >  	netdev->hw_enc_features |=3D netdev->vlan_features;
> > =20
> > +	netdev->xdp_features =3D NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRE=
CT |
> > +			       NETDEV_XDP_ACT_XSK_ZEROCOPY;
> > +
> >  	/* MTU range: 68 - 9216 */
> >  	netdev->min_mtu =3D ETH_MIN_MTU;
> >  	netdev->max_mtu =3D MAX_STD_JUMBO_FRAME_SIZE;
> > diff --git a/drivers/net/ethernet/intel/igc/igc_xdp.c b/drivers/net/eth=
ernet/intel/igc/igc_xdp.c
> > index aeeb34e64610..e27af72aada8 100644
> > --- a/drivers/net/ethernet/intel/igc/igc_xdp.c
> > +++ b/drivers/net/ethernet/intel/igc/igc_xdp.c
> > @@ -29,6 +29,11 @@ int igc_xdp_set_prog(struct igc_adapter *adapter, st=
ruct bpf_prog *prog,
> >  	if (old_prog)
> >  		bpf_prog_put(old_prog);
> > =20
> > +	if (prog)
> > +		xdp_features_set_redirect_target(dev, true);
> > +	else
> > +		xdp_features_clear_redirect_target(dev);
> > +
> >  	if (if_running)
> >  		igc_open(dev);
> > =20
> > diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/ne=
t/ethernet/intel/ixgbe/ixgbe_main.c
> > index 43a44c1e1576..af4c12b6059f 100644
> > --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> > +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> > @@ -10301,6 +10301,8 @@ static int ixgbe_xdp_setup(struct net_device *d=
ev, struct bpf_prog *prog)
> > =20
> >  		if (err)
> >  			return -EINVAL;
> > +		if (!prog)
> > +			xdp_features_clear_redirect_target(dev);
> >  	} else {
> >  		for (i =3D 0; i < adapter->num_rx_queues; i++) {
> >  			WRITE_ONCE(adapter->rx_ring[i]->xdp_prog,
> > @@ -10321,6 +10323,7 @@ static int ixgbe_xdp_setup(struct net_device *d=
ev, struct bpf_prog *prog)
> >  			if (adapter->xdp_ring[i]->xsk_pool)
> >  				(void)ixgbe_xsk_wakeup(adapter->netdev, i,
> >  						       XDP_WAKEUP_RX);
> > +		xdp_features_set_redirect_target(dev, true);
> >  	}
> > =20
> >  	return 0;
> > @@ -11018,6 +11021,9 @@ static int ixgbe_probe(struct pci_dev *pdev, co=
nst struct pci_device_id *ent)
> >  	netdev->priv_flags |=3D IFF_UNICAST_FLT;
> >  	netdev->priv_flags |=3D IFF_SUPP_NOFCS;
> > =20
> > +	netdev->xdp_features =3D NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRE=
CT |
> > +			       NETDEV_XDP_ACT_XSK_ZEROCOPY;
> > +
> >  	/* MTU range: 68 - 9710 */
> >  	netdev->min_mtu =3D ETH_MIN_MTU;
> >  	netdev->max_mtu =3D IXGBE_MAX_JUMBO_FRAME_SIZE - (ETH_HLEN + ETH_FCS_=
LEN);
> > diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/driver=
s/net/ethernet/intel/ixgbevf/ixgbevf_main.c
> > index ea0a230c1153..a44e4bd56142 100644
> > --- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
> > +++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
> > @@ -4634,6 +4634,7 @@ static int ixgbevf_probe(struct pci_dev *pdev, co=
nst struct pci_device_id *ent)
> >  			    NETIF_F_HW_VLAN_CTAG_TX;
> > =20
> >  	netdev->priv_flags |=3D IFF_UNICAST_FLT;
> > +	netdev->xdp_features =3D NETDEV_XDP_ACT_BASIC;
> > =20
> >  	/* MTU range: 68 - 1504 or 9710 */
> >  	netdev->min_mtu =3D ETH_MIN_MTU;
> > diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethern=
et/marvell/mvneta.c
> > index f8925cac61e4..dc2989103a77 100644
> > --- a/drivers/net/ethernet/marvell/mvneta.c
> > +++ b/drivers/net/ethernet/marvell/mvneta.c
> > @@ -5612,6 +5612,9 @@ static int mvneta_probe(struct platform_device *p=
dev)
> >  			NETIF_F_TSO | NETIF_F_RXCSUM;
> >  	dev->hw_features |=3D dev->features;
> >  	dev->vlan_features |=3D dev->features;
> > +	dev->xdp_features =3D NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT |
> > +			    NETDEV_XDP_ACT_NDO_XMIT | NETDEV_XDP_ACT_RX_SG |
> > +			    NETDEV_XDP_ACT_NDO_XMIT_SG;
> >  	dev->priv_flags |=3D IFF_LIVE_ADDR_CHANGE;
> >  	netif_set_tso_max_segs(dev, MVNETA_MAX_TSO_SEGS);
> > =20
> > diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/=
net/ethernet/marvell/mvpp2/mvpp2_main.c
> > index 4da45c5abba5..9b4ecbe4f36d 100644
> > --- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> > +++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> > @@ -6866,6 +6866,10 @@ static int mvpp2_port_probe(struct platform_devi=
ce *pdev,
> > =20
> >  	dev->vlan_features |=3D features;
> >  	netif_set_tso_max_segs(dev, MVPP2_MAX_TSO_SEGS);
> > +
> > +	dev->xdp_features =3D NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT |
> > +			    NETDEV_XDP_ACT_NDO_XMIT;
> > +
> >  	dev->priv_flags |=3D IFF_UNICAST_FLT;
> > =20
> >  	/* MTU range: 68 - 9704 */
> > diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/dri=
vers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> > index c1ea60bc2630..179433d0a54a 100644
> > --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> > +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> > @@ -2512,10 +2512,13 @@ static int otx2_xdp_setup(struct otx2_nic *pf, =
struct bpf_prog *prog)
> >  	/* Network stack and XDP shared same rx queues.
> >  	 * Use separate tx queues for XDP and network stack.
> >  	 */
> > -	if (pf->xdp_prog)
> > +	if (pf->xdp_prog) {
> >  		pf->hw.xdp_queues =3D pf->hw.rx_queues;
> > -	else
> > +		xdp_features_set_redirect_target(dev, false);
> > +	} else {
> >  		pf->hw.xdp_queues =3D 0;
> > +		xdp_features_clear_redirect_target(dev);
> > +	}
> > =20
> >  	pf->hw.tot_tx_queues +=3D pf->hw.xdp_queues;
> > =20
> > @@ -2878,6 +2881,7 @@ static int otx2_probe(struct pci_dev *pdev, const=
 struct pci_device_id *id)
> >  	netdev->watchdog_timeo =3D OTX2_TX_TIMEOUT;
> > =20
> >  	netdev->netdev_ops =3D &otx2_netdev_ops;
> > +	netdev->xdp_features =3D NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRE=
CT;
> > =20
> >  	netdev->min_mtu =3D OTX2_MIN_MTU;
> >  	netdev->max_mtu =3D otx2_get_max_mtu(pf);
> > diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/=
ethernet/mediatek/mtk_eth_soc.c
> > index 801deac58bf7..ac54b6f2bb5c 100644
> > --- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> > +++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> > @@ -4447,6 +4447,12 @@ static int mtk_add_mac(struct mtk_eth *eth, stru=
ct device_node *np)
> >  		register_netdevice_notifier(&mac->device_notifier);
> >  	}
> > =20
> > +	if (mtk_page_pool_enabled(eth))
> > +		eth->netdev[id]->xdp_features =3D NETDEV_XDP_ACT_BASIC |
> > +						NETDEV_XDP_ACT_REDIRECT |
> > +						NETDEV_XDP_ACT_NDO_XMIT |
> > +						NETDEV_XDP_ACT_NDO_XMIT_SG;
> > +
> >  	return 0;
> > =20
> >  free_netdev:
> > diff --git a/drivers/net/ethernet/mellanox/mlx4/en_netdev.c b/drivers/n=
et/ethernet/mellanox/mlx4/en_netdev.c
> > index af4c4858f397..e11bc0ac880e 100644
> > --- a/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
> > +++ b/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
> > @@ -3416,6 +3416,8 @@ int mlx4_en_init_netdev(struct mlx4_en_dev *mdev,=
 int port,
> >  		priv->rss_hash_fn =3D ETH_RSS_HASH_TOP;
> >  	}
> > =20
> > +	dev->xdp_features =3D NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT;
> > +
> >  	/* MTU range: 68 - hw-specific max */
> >  	dev->min_mtu =3D ETH_MIN_MTU;
> >  	dev->max_mtu =3D priv->max_mtu;
> > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/driver=
s/net/ethernet/mellanox/mlx5/core/en_main.c
> > index 0e87432ec6f1..e4996ef04d86 100644
> > --- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> > +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> > @@ -4780,6 +4780,13 @@ static int mlx5e_xdp_set(struct net_device *netd=
ev, struct bpf_prog *prog)
> >  	if (old_prog)
> >  		bpf_prog_put(old_prog);
> > =20
> > +	if (reset) {
> > +		if (prog)
> > +			xdp_features_set_redirect_target(netdev, true);
> > +		else
> > +			xdp_features_clear_redirect_target(netdev);
> > +	}
> > +
> >  	if (!test_bit(MLX5E_STATE_OPENED, &priv->state) || reset)
> >  		goto unlock;
> > =20
> > @@ -5175,6 +5182,10 @@ static void mlx5e_build_nic_netdev(struct net_de=
vice *netdev)
> >  	netdev->features         |=3D NETIF_F_HIGHDMA;
> >  	netdev->features         |=3D NETIF_F_HW_VLAN_STAG_FILTER;
> > =20
> > +	netdev->xdp_features =3D NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRE=
CT |
> > +			       NETDEV_XDP_ACT_XSK_ZEROCOPY |
> > +			       NETDEV_XDP_ACT_RX_SG;
> > +
> >  	netdev->priv_flags       |=3D IFF_UNICAST_FLT;
> > =20
> >  	netif_set_tso_max_size(netdev, GSO_MAX_SIZE);
> > diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/ne=
t/ethernet/microsoft/mana/mana_en.c
> > index 2f6a048dee90..6120f2b6684f 100644
> > --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> > +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> > @@ -2160,6 +2160,8 @@ static int mana_probe_port(struct mana_context *a=
c, int port_idx,
> >  	ndev->hw_features |=3D NETIF_F_RXHASH;
> >  	ndev->features =3D ndev->hw_features;
> >  	ndev->vlan_features =3D 0;
> > +	ndev->xdp_features =3D NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT=
 |
> > +			     NETDEV_XDP_ACT_NDO_XMIT;
> > =20
> >  	err =3D register_netdev(ndev);
> >  	if (err) {
> > diff --git a/drivers/net/ethernet/netronome/nfp/nfp_net_common.c b/driv=
ers/net/ethernet/netronome/nfp/nfp_net_common.c
> > index 18fc9971f1c8..e4825d885560 100644
> > --- a/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
> > +++ b/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
> > @@ -2529,10 +2529,15 @@ static void nfp_net_netdev_init(struct nfp_net =
*nn)
> >  	netdev->features &=3D ~NETIF_F_HW_VLAN_STAG_RX;
> >  	nn->dp.ctrl &=3D ~NFP_NET_CFG_CTRL_RXQINQ;
> > =20
> > +	netdev->xdp_features =3D NETDEV_XDP_ACT_BASIC;
> > +	if (nn->app && nn->app->type->id =3D=3D NFP_APP_BPF_NIC)
> > +		netdev->xdp_features |=3D NETDEV_XDP_ACT_HW_OFFLOAD;
> > +
> >  	/* Finalise the netdev setup */
> >  	switch (nn->dp.ops->version) {
> >  	case NFP_NFD_VER_NFD3:
> >  		netdev->netdev_ops =3D &nfp_nfd3_netdev_ops;
> > +		netdev->xdp_features |=3D NETDEV_XDP_ACT_XSK_ZEROCOPY;
> >  		break;
> >  	case NFP_NFD_VER_NFDK:
> >  		netdev->netdev_ops =3D &nfp_nfdk_netdev_ops;
> > diff --git a/drivers/net/ethernet/qlogic/qede/qede_main.c b/drivers/net=
/ethernet/qlogic/qede/qede_main.c
> > index 953f304b8588..b6d999927e86 100644
> > --- a/drivers/net/ethernet/qlogic/qede/qede_main.c
> > +++ b/drivers/net/ethernet/qlogic/qede/qede_main.c
> > @@ -892,6 +892,9 @@ static void qede_init_ndev(struct qede_dev *edev)
> > =20
> >  	ndev->hw_features =3D hw_features;
> > =20
> > +	ndev->xdp_features =3D NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT=
 |
> > +			     NETDEV_XDP_ACT_NDO_XMIT;
> > +
> >  	/* MTU range: 46 - 9600 */
> >  	ndev->min_mtu =3D ETH_ZLEN - ETH_HLEN;
> >  	ndev->max_mtu =3D QEDE_MAX_JUMBO_PACKET_SIZE;
> > diff --git a/drivers/net/ethernet/sfc/efx.c b/drivers/net/ethernet/sfc/=
efx.c
> > index 0556542d7a6b..18ff8d8cff42 100644
> > --- a/drivers/net/ethernet/sfc/efx.c
> > +++ b/drivers/net/ethernet/sfc/efx.c
> > @@ -1078,6 +1078,10 @@ static int efx_pci_probe(struct pci_dev *pci_dev,
> > =20
> >  	pci_info(pci_dev, "Solarflare NIC detected\n");
> > =20
> > +	efx->net_dev->xdp_features =3D NETDEV_XDP_ACT_BASIC |
> > +				     NETDEV_XDP_ACT_REDIRECT |
> > +				     NETDEV_XDP_ACT_NDO_XMIT;
> > +
>=20
> Put this in efx_pci_probe_post_io() please, that is where all the other
> basic netdev features are initialised.

ack, I will post a follow-up patch.

Regards,
Lorenzo

>=20
> >  	if (!efx->type->is_vf)
> >  		efx_probe_vpd_strings(efx);
> > =20
> > diff --git a/drivers/net/ethernet/sfc/siena/efx.c b/drivers/net/etherne=
t/sfc/siena/efx.c
> > index 60e5b7c8ccf9..a6ef21845224 100644
> > --- a/drivers/net/ethernet/sfc/siena/efx.c
> > +++ b/drivers/net/ethernet/sfc/siena/efx.c
> > @@ -1048,6 +1048,10 @@ static int efx_pci_probe(struct pci_dev *pci_dev,
> > =20
> >  	pci_info(pci_dev, "Solarflare NIC detected\n");
> > =20
> > +	efx->net_dev->xdp_features =3D NETDEV_XDP_ACT_BASIC |
> > +				     NETDEV_XDP_ACT_REDIRECT |
> > +				     NETDEV_XDP_ACT_NDO_XMIT;
> > +
>=20
> Same comment here.
>=20
> Martin
>=20
> >  	if (!efx->type->is_vf)
> >  		efx_probe_vpd_strings(efx);
> > =20
> > diff --git a/drivers/net/ethernet/socionext/netsec.c b/drivers/net/ethe=
rnet/socionext/netsec.c
> > index 9b46579b5a10..2d7347b71c41 100644
> > --- a/drivers/net/ethernet/socionext/netsec.c
> > +++ b/drivers/net/ethernet/socionext/netsec.c
> > @@ -2104,6 +2104,9 @@ static int netsec_probe(struct platform_device *p=
dev)
> >  				NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM;
> >  	ndev->hw_features =3D ndev->features;
> > =20
> > +	ndev->xdp_features =3D NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT=
 |
> > +			     NETDEV_XDP_ACT_NDO_XMIT;
> > +
> >  	priv->rx_cksum_offload_flag =3D true;
> > =20
> >  	ret =3D netsec_register_mdio(priv, phy_addr);
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/driver=
s/net/ethernet/stmicro/stmmac/stmmac_main.c
> > index b7e5af58ab75..734d84263fd2 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > @@ -7150,6 +7150,8 @@ int stmmac_dvr_probe(struct device *device,
> > =20
> >  	ndev->hw_features =3D NETIF_F_SG | NETIF_F_IP_CSUM | NETIF_F_IPV6_CSU=
M |
> >  			    NETIF_F_RXCSUM;
> > +	ndev->xdp_features =3D NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT=
 |
> > +			     NETDEV_XDP_ACT_NDO_XMIT;
> > =20
> >  	ret =3D stmmac_tc_init(priv, priv);
> >  	if (!ret) {
> > diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/c=
psw.c
> > index 13c9c2d6b79b..37f0b62ec5d6 100644
> > --- a/drivers/net/ethernet/ti/cpsw.c
> > +++ b/drivers/net/ethernet/ti/cpsw.c
> > @@ -1458,6 +1458,8 @@ static int cpsw_probe_dual_emac(struct cpsw_priv =
*priv)
> >  	priv_sl2->emac_port =3D 1;
> >  	cpsw->slaves[1].ndev =3D ndev;
> >  	ndev->features |=3D NETIF_F_HW_VLAN_CTAG_FILTER | NETIF_F_HW_VLAN_CTA=
G_RX;
> > +	ndev->xdp_features =3D NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT=
 |
> > +			     NETDEV_XDP_ACT_NDO_XMIT;
> > =20
> >  	ndev->netdev_ops =3D &cpsw_netdev_ops;
> >  	ndev->ethtool_ops =3D &cpsw_ethtool_ops;
> > @@ -1635,6 +1637,8 @@ static int cpsw_probe(struct platform_device *pde=
v)
> >  	cpsw->slaves[0].ndev =3D ndev;
> > =20
> >  	ndev->features |=3D NETIF_F_HW_VLAN_CTAG_FILTER | NETIF_F_HW_VLAN_CTA=
G_RX;
> > +	ndev->xdp_features =3D NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT=
 |
> > +			     NETDEV_XDP_ACT_NDO_XMIT;
> > =20
> >  	ndev->netdev_ops =3D &cpsw_netdev_ops;
> >  	ndev->ethtool_ops =3D &cpsw_ethtool_ops;
> > diff --git a/drivers/net/ethernet/ti/cpsw_new.c b/drivers/net/ethernet/=
ti/cpsw_new.c
> > index 83596ec0c7cb..35128dd45ffc 100644
> > --- a/drivers/net/ethernet/ti/cpsw_new.c
> > +++ b/drivers/net/ethernet/ti/cpsw_new.c
> > @@ -1405,6 +1405,10 @@ static int cpsw_create_ports(struct cpsw_common =
*cpsw)
> >  		ndev->features |=3D NETIF_F_HW_VLAN_CTAG_FILTER |
> >  				  NETIF_F_HW_VLAN_CTAG_RX | NETIF_F_NETNS_LOCAL | NETIF_F_HW_TC;
> > =20
> > +		ndev->xdp_features =3D NETDEV_XDP_ACT_BASIC |
> > +				     NETDEV_XDP_ACT_REDIRECT |
> > +				     NETDEV_XDP_ACT_NDO_XMIT;
> > +
> >  		ndev->netdev_ops =3D &cpsw_netdev_ops;
> >  		ndev->ethtool_ops =3D &cpsw_ethtool_ops;
> >  		SET_NETDEV_DEV(ndev, dev);
> > diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvs=
c_drv.c
> > index f9b219e6cd58..a9b139bbdb2c 100644
> > --- a/drivers/net/hyperv/netvsc_drv.c
> > +++ b/drivers/net/hyperv/netvsc_drv.c
> > @@ -2559,6 +2559,8 @@ static int netvsc_probe(struct hv_device *dev,
> > =20
> >  	netdev_lockdep_set_classes(net);
> > =20
> > +	net->xdp_features =3D NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT;
> > +
> >  	/* MTU range: 68 - 1500 or 65521 */
> >  	net->min_mtu =3D NETVSC_MTU_MIN;
> >  	if (nvdev->nvsp_version >=3D NVSP_PROTOCOL_VERSION_2)
> > diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/net=
dev.c
> > index 6db6a75ff9b9..35fa1ca98671 100644
> > --- a/drivers/net/netdevsim/netdev.c
> > +++ b/drivers/net/netdevsim/netdev.c
> > @@ -286,6 +286,7 @@ static void nsim_setup(struct net_device *dev)
> >  			 NETIF_F_TSO;
> >  	dev->hw_features |=3D NETIF_F_HW_TC;
> >  	dev->max_mtu =3D ETH_MAX_MTU;
> > +	dev->xdp_features =3D NETDEV_XDP_ACT_HW_OFFLOAD;
> >  }
> > =20
> >  static int nsim_init_netdevsim(struct netdevsim *ns)
> > diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> > index a7d17c680f4a..36620afde373 100644
> > --- a/drivers/net/tun.c
> > +++ b/drivers/net/tun.c
> > @@ -1401,6 +1401,11 @@ static void tun_net_initialize(struct net_device=
 *dev)
> > =20
> >  		eth_hw_addr_random(dev);
> > =20
> > +		/* Currently tun does not support XDP, only tap does. */
> > +		dev->xdp_features =3D NETDEV_XDP_ACT_BASIC |
> > +				    NETDEV_XDP_ACT_REDIRECT |
> > +				    NETDEV_XDP_ACT_NDO_XMIT;
> > +
> >  		break;
> >  	}
> > =20
> > diff --git a/drivers/net/veth.c b/drivers/net/veth.c
> > index ba3e05832843..1bb54de7124d 100644
> > --- a/drivers/net/veth.c
> > +++ b/drivers/net/veth.c
> > @@ -1686,6 +1686,10 @@ static void veth_setup(struct net_device *dev)
> >  	dev->hw_enc_features =3D VETH_FEATURES;
> >  	dev->mpls_features =3D NETIF_F_HW_CSUM | NETIF_F_GSO_SOFTWARE;
> >  	netif_set_tso_max_size(dev, GSO_MAX_SIZE);
> > +
> > +	dev->xdp_features =3D NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT |
> > +			    NETDEV_XDP_ACT_NDO_XMIT | NETDEV_XDP_ACT_RX_SG |
> > +			    NETDEV_XDP_ACT_NDO_XMIT_SG;
> >  }
> > =20
> >  /*
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 7e1a98430190..692dff071782 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -3280,7 +3280,10 @@ static int virtnet_xdp_set(struct net_device *de=
v, struct bpf_prog *prog,
> >  			if (i =3D=3D 0 && !old_prog)
> >  				virtnet_clear_guest_offloads(vi);
> >  		}
> > +		if (!old_prog)
> > +			xdp_features_set_redirect_target(dev, false);
> >  	} else {
> > +		xdp_features_clear_redirect_target(dev);
> >  		vi->xdp_enabled =3D false;
> >  	}
> > =20
> > @@ -3910,6 +3913,7 @@ static int virtnet_probe(struct virtio_device *vd=
ev)
> >  		dev->hw_features |=3D NETIF_F_GRO_HW;
> > =20
> >  	dev->vlan_features =3D dev->features;
> > +	dev->xdp_features =3D NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT;
> > =20
> >  	/* MTU range: 68 - 65535 */
> >  	dev->min_mtu =3D MIN_MTU;
> > diff --git a/drivers/net/xen-netfront.c b/drivers/net/xen-netfront.c
> > index 12b074286df9..47d54d8ea59d 100644
> > --- a/drivers/net/xen-netfront.c
> > +++ b/drivers/net/xen-netfront.c
> > @@ -1741,6 +1741,8 @@ static struct net_device *xennet_create_dev(struc=
t xenbus_device *dev)
> >           * negotiate with the backend regarding supported features.
> >           */
> >  	netdev->features |=3D netdev->hw_features;
> > +	netdev->xdp_features =3D NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRE=
CT |
> > +			       NETDEV_XDP_ACT_NDO_XMIT;
> > =20
> >  	netdev->ethtool_ops =3D &xennet_ethtool_ops;
> >  	netdev->min_mtu =3D ETH_MIN_MTU;
> > diff --git a/include/net/xdp.h b/include/net/xdp.h
> > index 8d1c86914f4c..d517bfac937b 100644
> > --- a/include/net/xdp.h
> > +++ b/include/net/xdp.h
> > @@ -428,9 +428,21 @@ MAX_XDP_METADATA_KFUNC,
> >  #ifdef CONFIG_NET
> >  u32 bpf_xdp_metadata_kfunc_id(int id);
> >  bool bpf_dev_bound_kfunc_id(u32 btf_id);
> > +void xdp_features_set_redirect_target(struct net_device *dev, bool sup=
port_sg);
> > +void xdp_features_clear_redirect_target(struct net_device *dev);
> >  #else
> >  static inline u32 bpf_xdp_metadata_kfunc_id(int id) { return 0; }
> >  static inline bool bpf_dev_bound_kfunc_id(u32 btf_id) { return false; }
> > +
> > +static inline void
> > +xdp_features_set_redirect_target(struct net_device *dev, bool support_=
sg)
> > +{
> > +}
> > +
> > +static inline void
> > +xdp_features_clear_redirect_target(struct net_device *dev)
> > +{
> > +}
> >  #endif
> > =20
> >  #endif /* __LINUX_NET_XDP_H__ */
> > diff --git a/net/core/xdp.c b/net/core/xdp.c
> > index a5a7ecf6391c..82727b47259d 100644
> > --- a/net/core/xdp.c
> > +++ b/net/core/xdp.c
> > @@ -773,3 +773,21 @@ static int __init xdp_metadata_init(void)
> >  	return register_btf_kfunc_id_set(BPF_PROG_TYPE_XDP, &xdp_metadata_kfu=
nc_set);
> >  }
> >  late_initcall(xdp_metadata_init);
> > +
> > +void xdp_features_set_redirect_target(struct net_device *dev, bool sup=
port_sg)
> > +{
> > +	dev->xdp_features |=3D NETDEV_XDP_ACT_NDO_XMIT;
> > +	if (support_sg)
> > +		dev->xdp_features |=3D NETDEV_XDP_ACT_NDO_XMIT_SG;
> > +
> > +	call_netdevice_notifiers(NETDEV_XDP_FEAT_CHANGE, dev);
> > +}
> > +EXPORT_SYMBOL_GPL(xdp_features_set_redirect_target);
> > +
> > +void xdp_features_clear_redirect_target(struct net_device *dev)
> > +{
> > +	dev->xdp_features &=3D ~(NETDEV_XDP_ACT_NDO_XMIT |
> > +			       NETDEV_XDP_ACT_NDO_XMIT_SG);
> > +	call_netdevice_notifiers(NETDEV_XDP_FEAT_CHANGE, dev);
> > +}
> > +EXPORT_SYMBOL_GPL(xdp_features_clear_redirect_target);
> > --=20
> > 2.39.1

--TAZHCJTWsWnAkEmY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCY+IiYwAKCRA6cBh0uS2t
rCU5APwJLF/MntvsP/r7UZjYZ60tGp0NHDVVdjMT0TB419WhZwEA9AUCQx3uMvrC
LVtcfSe9yN4lt9Rj7TkWmabUSqz7xA8=
=RIZ1
-----END PGP SIGNATURE-----

--TAZHCJTWsWnAkEmY--
