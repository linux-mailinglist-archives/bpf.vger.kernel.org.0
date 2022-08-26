Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FAB15A1F1F
	for <lists+bpf@lfdr.de>; Fri, 26 Aug 2022 04:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244493AbiHZCwY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Aug 2022 22:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiHZCwX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Aug 2022 22:52:23 -0400
Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 707A1CCE3D;
        Thu, 25 Aug 2022 19:52:21 -0700 (PDT)
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id AA1B872C90B;
        Fri, 26 Aug 2022 05:52:20 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id 8E04C4A470D;
        Fri, 26 Aug 2022 05:52:20 +0300 (MSK)
Date:   Fri, 26 Aug 2022 05:52:20 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        dwarves@vger.kernel.org, bpf <bpf@vger.kernel.org>,
        Martin Reboredo <yakoyoku@gmail.com>
Subject: Re: pahole v1.24: FAILED: load BTF from vmlinux: Invalid argument
Message-ID: <20220826025220.cxfwwpem2ycpvrmm@altlinux.org>
References: <20220825163538.vajnsv3xcpbhl47v@altlinux.org>
 <CA+JHD904e2TPpz1ybsaaqD+qMTDcueXu4nVcmotEPhxNfGN+Gw@mail.gmail.com>
 <20220825171620.cioobudss6ovyrkc@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20220825171620.cioobudss6ovyrkc@altlinux.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Arnaldo,

On Thu, Aug 25, 2022 at 08:16:20PM +0300, Vitaly Chikunov wrote:
> On Thu, Aug 25, 2022 at 01:47:59PM -0300, Arnaldo Carvalho de Melo wrote:
> > On Thu, Aug 25, 2022, 1:35 PM Vitaly Chikunov <vt@altlinux.org> wrote:
> > >
> > > I also noticed that after upgrading pahole to v1.24 kernel build (tested on
> > > v5.18.19, v5.15.63, sorry for not testing on mainline) fails with:
> > >
> > >     BTFIDS  vmlinux
> > >   + ./tools/bpf/resolve_btfids/resolve_btfids vmlinux
> > >   FAILED: load BTF from vmlinux: Invalid argument
> > >
> > > Perhaps, .tmp_vmlinux.btf is generated incorrectly? Downgrading dwarves to
> > > v1.23 resolves the issue.
> > >
> > 
> > Can you try this, from Martin Reboredo (Archlinux):
> > 
> > Can you try a build of the kernel or the by passing the
> > --skip_encoding_btf_enum64 to scripts/pahole-flags.sh?
> > 
> > Here's a patch for either in tree scripts/pahole-flags.sh or
> > /usr/lib/modules/5.19.3-arch1-1/build/scripts/pahole-flags.sh
> 
> This patch helped and kernel builds successfully after applying it.
> (Didn't notice this suggestion in release discussion thread.)

Even thought it now compiles with this patch, it does not boot
afterwards (in virtme-like env), witch such console messages:

  [    0.767649] Run /init as init process
  [    0.770858] BPF:[593] ENUM perf_event_task_context
  [    0.771262] BPF:size=4 vlen=4
  [    0.771511] BPF:
  [    0.771680] BPF:Invalid btf_info kind_flag
  [    0.772016] BPF:
  [    0.772016]
  [    0.772288] failed to validate module [9pnet] BTF: -22
  init_module '9pnet.ko' error -1
  [    0.785515] 9p: Unknown symbol p9_client_getattr_dotl (err -2)
  [    0.786005] 9p: Unknown symbol p9_client_wstat (err -2)
  [    0.786438] 9p: Unknown symbol p9_client_open (err -2)
  [    0.786863] 9p: Unknown symbol p9_client_rename (err -2)
  [    0.787307] 9p: Unknown symbol p9_client_remove (err -2)
  [    0.787749] 9p: Unknown symbol p9_client_renameat (err -2)
  [    0.788202] 9p: Unknown symbol p9_client_fcreate (err -2)
  [    0.788651] 9p: Unknown symbol p9_is_proto_dotu (err -2)
  [    0.789086] 9p: Unknown symbol p9_client_disconnect (err -2)
  [    0.789558] 9p: Unknown symbol p9_client_attach (err -2)
  [    0.790001] 9p: Unknown symbol p9stat_free (err -2)
  [    0.790409] 9p: Unknown symbol p9_client_create (err -2)
  [    0.790856] 9p: Unknown symbol p9_client_read_once (err -2)
  [    0.791314] 9p: Unknown symbol p9_client_setattr (err -2)
  [    0.791762] 9p: Unknown symbol p9_client_xattrwalk (err -2)
  [    0.792222] 9p: Unknown symbol p9_client_destroy (err -2)
  [    0.792674] 9p: Unknown symbol p9_client_unlinkat (err -2)
  [    0.793124] 9p: Unknown symbol p9_client_mkdir_dotl (err -2)
  [    0.793585] 9p: Unknown symbol p9_client_xattrcreate (err -2)
  [    0.794055] 9p: Unknown symbol p9_client_create_dotl (err -2)
  [    0.794527] 9p: Unknown symbol p9_client_lock_dotl (err -2)
  [    0.794985] 9p: Unknown symbol p9_client_write (err -2)
  [    0.795415] 9p: Unknown symbol p9_client_walk (err -2)
  [    0.795837] 9p: Unknown symbol p9_show_client_options (err -2)
  [    0.796308] 9p: Unknown symbol p9_client_read (err -2)
  [    0.796731] 9p: Unknown symbol p9_client_fsync (err -2)
  [    0.797158] 9p: Unknown symbol p9dirent_read (err -2)
  [    0.797572] 9p: Unknown symbol p9_client_symlink (err -2)
  [    0.798016] 9p: Unknown symbol p9_client_readlink (err -2)
  [    0.798470] 9p: Unknown symbol p9_is_proto_dotl (err -2)
  [    0.798908] 9p: Unknown symbol p9_client_clunk (err -2)
  [    0.799339] 9p: Unknown symbol p9stat_read (err -2)
  [    0.799747] 9p: Unknown symbol p9_client_statfs (err -2)
  [    0.800184] 9p: Unknown symbol p9_client_link (err -2)
  [    0.800612] 9p: Unknown symbol p9_client_stat (err -2)
  [    0.801038] 9p: Unknown symbol p9_client_begin_disconnect (err -2)
  [    0.801544] 9p: Unknown symbol p9_client_getlock_dotl (err -2)
  [    0.802024] 9p: Unknown symbol p9_client_readdir (err -2)
  [    0.802469] 9p: Unknown symbol p9_client_mknod_dotl (err -2)
  init_module '9p.ko' error -1
  [    0.809193] failed to validate module [virtio] BTF: -22
  init_module 'virtio.ko' error -1
  [    0.825316] failed to validate module [virtio_ring] BTF: -22
  init_module 'virtio_ring.ko' error -1
  [    0.841110] 9pnet_virtio: Unknown symbol register_virtio_driver (err -2)
  [    0.841674] 9pnet_virtio: Unknown symbol p9_req_put (err -2)
  [    0.842143] 9pnet_virtio: Unknown symbol unregister_virtio_driver (err -2)
  [    0.842708] 9pnet_virtio: Unknown symbol p9_release_pages (err -2)
  [    0.843209] 9pnet_virtio: Unknown symbol virtqueue_add_sgs (err -2)
  [    0.843728] 9pnet_virtio: Unknown symbol virtqueue_get_buf (err -2)
  [    0.844237] 9pnet_virtio: Unknown symbol virtqueue_kick (err -2)
  [    0.844733] 9pnet_virtio: Unknown symbol v9fs_register_trans (err -2)
  [    0.845256] 9pnet_virtio: Unknown symbol virtio_check_driver_offered_feature (err -2)
  [    0.845893] 9pnet_virtio: Unknown symbol v9fs_unregister_trans (err -2)
  [    0.846434] 9pnet_virtio: Unknown symbol p9_client_cb (err -2)
  init_module '9pnet_virtio.ko' error -1
  [    0.853175] failed to validate module [virtio_pci_modern_dev] BTF: -22
  init_module 'virtio_pci_modern_dev.ko' error -1
  [    0.869196] virtio_pci: Unknown symbol vring_transport_features (err -2)
  [    0.869759] virtio_pci: Unknown symbol vp_modern_get_status (err -2)
  [    0.870276] virtio_pci: Unknown symbol vp_modern_map_vq_notify (err -2)
  [    0.870817] virtio_pci: Unknown symbol virtqueue_get_avail_addr (err -2)
  [    0.871363] virtio_pci: Unknown symbol vp_modern_get_queue_size (err -2)
  [    0.871912] virtio_pci: Unknown symbol vp_modern_remove (err -2)
  [    0.872405] virtio_pci: Unknown symbol vring_create_virtqueue (err -2)
  [    0.872938] virtio_pci: Unknown symbol vp_modern_get_features (err -2)
  [    0.873470] virtio_pci: Unknown symbol vp_modern_set_status (err -2)
  [    0.873986] virtio_pci: Unknown symbol vp_modern_queue_address (err -2)
  [    0.874523] virtio_pci: Unknown symbol virtio_device_restore (err -2)
  [    0.875050] virtio_pci: Unknown symbol vring_interrupt (err -2)
  [    0.875544] virtio_pci: Unknown symbol virtio_config_changed (err -2)
  [    0.876073] virtio_pci: Unknown symbol vp_modern_get_queue_enable (err -2)
  [    0.876639] virtio_pci: Unknown symbol vp_modern_config_vector (err -2)
  [    0.877172] virtio_pci: Unknown symbol virtqueue_get_vring_size (err -2)
  [    0.877721] virtio_pci: Unknown symbol vp_modern_probe (err -2)
  [    0.878205] virtio_pci: Unknown symbol unregister_virtio_device (err -2)
  [    0.878753] virtio_pci: Unknown symbol virtqueue_get_desc_addr (err -2)
  [    0.879288] virtio_pci: Unknown symbol vp_modern_set_queue_size (err -2)
  [    0.879836] virtio_pci: Unknown symbol vp_modern_queue_vector (err -2)
  [    0.880371] virtio_pci: Unknown symbol virtio_device_freeze (err -2)
  [    0.880896] virtio_pci: Unknown symbol vp_modern_generation (err -2)
  [    0.881417] virtio_pci: Unknown symbol virtio_break_device (err -2)
  [    0.881969] virtio_pci: Unknown symbol vp_modern_set_features (err -2)
  [    0.882501] virtio_pci: Unknown symbol virtqueue_get_used_addr (err -2)
  [    0.883014] virtio_pci: Unknown symbol register_virtio_device (err -2)
  [    0.883547] virtio_pci: Unknown symbol vp_modern_get_num_queues (err -2)
  [    0.884090] virtio_pci: Unknown symbol vp_modern_set_queue_enable (err -2)
  [    0.884684] virtio_pci: Unknown symbol vring_del_virtqueue (err -2)
  init_module 'virtio_pci.ko' error -1

It seems the same is happened in Arch:

  https://bbs.archlinux.org/viewtopic.php?id=279132

And they reverted pahole to 1.23:

  https://github.com/archlinux/svntogit-packages/commits/packages/pahole/trunk/PKGBUILD

When I'm revering dwarves to 1.23 it resolves the issue for me too (in
ALT).

Thanks,


> 
> Thanks!
> 
> > 
> > diff --git a/scripts/pahole-flags.sh b/scripts/pahole-flags.sh
> > index 0d99ef17e4a528..1f1f1d397c399a 100755
> > --- a/scripts/pahole-flags.sh
> > +++ b/scripts/pahole-flags.sh
> > @@ -19,5 +19,9 @@ fi
> >  if [ "${pahole_ver}" -ge "122" ]; then
> >         extra_paholeopt="${extra_paholeopt} -j"
> >  fi
> > +if [ "${pahole_ver}" -ge "124" ]; then
> > +       # see PAHOLE_HAS_LANG_EXCLUDE
> > +       extra_paholeopt="${extra_paholeopt} --skip_encoding_btf_enum64"
> > +fi
> > 
> >  echo ${extra_paholeopt}
> > 
> > >
> > > Thanks,
> > >
> > >
