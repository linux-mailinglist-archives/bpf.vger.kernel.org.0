Return-Path: <bpf+bounces-31509-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 292E28FF267
	for <lists+bpf@lfdr.de>; Thu,  6 Jun 2024 18:24:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7A2028B8A7
	for <lists+bpf@lfdr.de>; Thu,  6 Jun 2024 16:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE9691990A7;
	Thu,  6 Jun 2024 16:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NWhJBPM7"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E09196C72;
	Thu,  6 Jun 2024 16:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717690939; cv=none; b=QpiLoKdbhii9zoSbguFOobE46KelOyW0nAfyx/erC/m2Gt0X6y2fxt+2VjKcYv2BSjNIjIyP88t7OldM1+lOKpdAdKuGdqzFwTXsw59Hx5DDESx6v5jRUYtnQaSr4Z/pfXnsIo+R2SoVptxoULDPPRIQxGK1E6YSzSR+2+cLbP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717690939; c=relaxed/simple;
	bh=O6joZNfO4WVVBwJWQ3bJy89M31e/TXm/ojMqVmHXu5M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nR5Qd1TnfpBNzw4/kVn9HHkRg4XmAZ1xcX7t4WFV8McXCnLDz8rWNtvBcQtJ8ssGPJMWzbNA4rxPsGDQ6pUWfJCSatBoaCK9vHwWlYCRKiMOeeplxyxnyo8EAnm4bB1VAt4wim+5Fyyf8ricpwXEQFSwslnbqfeIE1nzq6w/ezg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NWhJBPM7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 581E1C2BD10;
	Thu,  6 Jun 2024 16:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717690938;
	bh=O6joZNfO4WVVBwJWQ3bJy89M31e/TXm/ojMqVmHXu5M=;
	h=From:To:Cc:Subject:Date:From;
	b=NWhJBPM7Ve1y2L6D3phMah5SQX8oYIOqCL+Bwxw7vaLDdSylelIbFYXy/kre+tZEH
	 GxHXeAPo14+SF+r2pOrSBvDplF7ZmZ/uXIZ34X5OK8q8hgRNrKF/xx0KQSkLwILGBL
	 E9yBwkNzRJjoUShdRaF860kuyz49DlrPhXiUBBYGwpshMz/YkVZjcOH8o09RxtfNIn
	 kVgq26Ez6/h60dQWxI1WkqCd1xKAmAYGxOlrpS0ay91C7VnXV5jX0DnL4+EKWsfnhd
	 knRk7nu9I3xwsi/oHY0zoPldlgpxuLsZTkYu5P84pgqqxFf7rl8JTmznNQFHk7ogF5
	 gnOOE1ykubNrQ==
From: Jakub Kicinski <kuba@kernel.org>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pabeni@redhat.com,
	bpf@vger.kernel.org
Subject: [GIT PULL] Networking for v6.10-rc3
Date: Thu,  6 Jun 2024 09:22:17 -0700
Message-ID: <20240606162217.3203895-1-kuba@kernel.org>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Linus!

The following changes since commit d8ec19857b095b39d114ae299713bd8ea6c1e66a:

  Merge tag 'net-6.10-rc2' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2024-05-30 08:33:04 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.10-rc3

for you to fetch changes up to 27bc86540899ee793ab2f4c846e745aa0de443f1:

  Merge branch 'selftests-net-lib-small-fixes' (2024-06-06 08:29:07 -0700)

----------------------------------------------------------------
Including fixes from BPF and big collection of fixes for WiFi core
and drivers.

Current release - regressions:

 - vxlan: fix regression when dropping packets due to invalid src addresses

 - bpf: fix a potential use-after-free in bpf_link_free()

 - xdp: revert support for redirect to any xsk socket bound to the same
   UMEM as it can result in a corruption

 - virtio_net:
   - add missing lock protection when reading return code from control_buf
   - fix false-positive lockdep splat in DIM
   - Revert "wifi: wilc1000: convert list management to RCU"

 - wifi: ath11k: fix error path in ath11k_pcic_ext_irq_config

Previous releases - regressions:

 - rtnetlink: make the "split" NLM_DONE handling generic, restore the old
   behavior for two cases where we started coalescing those messages with
   normal messages, breaking sloppily-coded userspace

 - wifi:
   - cfg80211: validate HE operation element parsing
   - cfg80211: fix 6 GHz scan request building
   - mt76: mt7615: add missing chanctx ops
   - ath11k: move power type check to ASSOC stage, fix connecting
     to 6 GHz AP
   - ath11k: fix WCN6750 firmware crash caused by 17 num_vdevs
   - rtlwifi: ignore IEEE80211_CONF_CHANGE_RETRY_LIMITS
   - iwlwifi: mvm: fix a crash on 7265

Previous releases - always broken:

 - ncsi: prevent multi-threaded channel probing, a spec violation

 - vmxnet3: disable rx data ring on dma allocation failure

 - ethtool: init tsinfo stats if requested, prevent unintentionally
   reporting all-zero stats on devices which don't implement any

 - dst_cache: fix possible races in less common IPv6 features

 - tcp: auth: don't consider TCP_CLOSE to be in TCP_AO_ESTABLISHED

 - ax25: fix two refcounting bugs

 - eth: ionic: fix kernel panic in XDP_TX action

Misc:

 - tcp: count CLOSE-WAIT sockets for TCP_MIB_CURRESTAB

Signed-off-by: Jakub Kicinski <kuba@kernel.org>

----------------------------------------------------------------
Aditya Kumar Singh (1):
      wifi: mac80211: pass proper link id for channel switch started notification

Aleksandr Mishin (2):
      net/mlx5: Fix tainted pointer delete is case of flow rules creation fail
      net: wwan: iosm: Fix tainted pointer delete is case of region creation fail

Alexis Lothoré (3):
      Revert "wifi: wilc1000: convert list management to RCU"
      Revert "wifi: wilc1000: set atomic flag on kmemdup in srcu critical section"
      wifi: wilc1000: document SRCU usage instead of SRCU

Andrii Nakryiko (2):
      selftests/bpf: fix inet_csk_accept prototype in test_sk_storage_tracing.c
      libbpf: don't close(-1) in multi-uprobe feature detector

Ayala Beker (1):
      wifi: iwlwifi: mvm: properly set 6 GHz channel direct probe option

Baochen Qiang (1):
      wifi: ath11k: move power type check to ASSOC stage when connecting to 6 GHz AP

Benjamin Berg (1):
      wifi: iwlwifi: mvm: remove stale STA link data during restart

Bitterblue Smith (1):
      wifi: rtlwifi: Ignore IEEE80211_CONF_CHANGE_RETRY_LIMITS

Breno Leitao (1):
      wifi: ath11k: Fix error path in ath11k_pcic_ext_irq_config

Carl Huang (1):
      wifi: ath11k: fix WCN6750 firmware crash caused by 17 num_vdevs

Cong Wang (1):
      bpf: Fix a potential use-after-free in bpf_link_free()

Daniel Borkmann (1):
      vxlan: Fix regression when dropping packets due to invalid src addresses

David S. Miller (2):
      Merge branch 'tcp-mptcp-close-wait'
      Merge branch 'mlx5-fixes'

DelphineCCChiu (1):
      net/ncsi: Fix the multi thread manner of NCSI driver

Dmitry Antipov (1):
      wifi: mac80211: fix UBSAN noise in ieee80211_prep_hw_scan()

Dmitry Baryshkov (1):
      wifi: ath10k: fix QCOM_RPROC_COMMON dependency

Dmitry Safonov (1):
      net/tcp: Don't consider TCP_CLOSE in TCP_AO_ESTABLISHED

Duoming Zhou (1):
      ax25: Replace kfree() in ax25_dev_free() with ax25_dev_put()

Emmanuel Grumbach (2):
      wifi: iwlwifi: mvm: fix a crash on 7265
      wifi: iwlwifi: mvm: don't read past the mfuart notifcation

Eric Dumazet (7):
      ipv6: ioam: block BH from ioam6_output()
      net: ipv6: rpl_iptunnel: block BH in rpl_output() and rpl_input()
      ipv6: sr: block BH in seg6_output_core() and seg6_input_core()
      ila: block BH in ila_output()
      net: dst_cache: add two DEBUG_NET warnings
      net/sched: taprio: always validate TCA_TAPRIO_ATTR_PRIOMAP
      ipv6: fix possible race in __fib6_drop_pcpu_from()

Frank Wunderlich (1):
      net: ethernet: mtk_eth_soc: handle dma buffer size soc specific

Hangbin Liu (1):
      selftests: hsr: add missing config for CONFIG_BRIDGE

Hangyu Hua (1):
      net: sched: sch_multiq: fix possible OOB write in multiq_tune()

Heng Qi (3):
      virtio_net: fix missing lock protection on control_buf access
      virtio_net: fix possible dim status unrecoverable
      virtio_net: fix a spurious deadlock issue

Ilan Peer (1):
      wifi: iwlwifi: mvm: Fix scan abort handling with HW rfkill

Jacob Keller (2):
      ice: fix iteration of TLVs in Preserved Fields Area
      ice: fix reads from NVM Shadow RAM on E830 and E825-C devices

Jakub Kicinski (8):
      Merge branch 'virtio_net-fix-lock-warning-and-unrecoverable-state'
      Merge branch 'dst_cache-fix-possible-races'
      Merge tag 'wireless-2024-06-03' of git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless
      net: tls: fix marking packets as decrypted
      rtnetlink: make the "split" NLM_DONE handling generic
      Merge tag 'for-netdev' of https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf
      Merge branch 'intel-wired-lan-driver-updates-2024-05-29-ice-igc'
      Merge branch 'selftests-net-lib-small-fixes'

Jason Xing (3):
      net: rps: fix error when CONFIG_RFS_ACCEL is off
      tcp: count CLOSE-WAIT sockets for TCP_MIB_CURRESTAB
      mptcp: count CLOSE-WAIT sockets for MPTCP_MIB_CURRESTAB

Jeff Johnson (1):
      lib/test_rhashtable: add missing MODULE_DESCRIPTION() macro

Jiri Olsa (2):
      bpf: Fix bpf_session_cookie BTF_ID in special_kfunc_set list
      bpf: Set run context for rawtp test_run callback

Johannes Berg (8):
      wifi: cfg80211: validate HE operation element parsing
      wifi: cfg80211: fully move wiphy work to unbound workqueue
      wifi: mac80211: apply mcast rate only if interface is up
      wifi: mac80211: handle tasklet frames before stopping
      wifi: cfg80211: fix 6 GHz scan request building
      wifi: iwlwifi: mvm: revert gen2 TX A-MPDU size to 64
      wifi: iwlwifi: mvm: handle BA session teardown in RF-kill
      wifi: mt76: mt7615: add missing chanctx ops

Kalle Valo (1):
      Merge tag 'ath-current-20240531' of git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath

Karol Kolacinski (1):
      ptp: Fix error message on failed pin verification

Kuniyuki Iwashima (15):
      af_unix: Set sk->sk_state under unix_state_lock() for truly disconencted peer.
      af_unix: Annodate data-races around sk->sk_state for writers.
      af_unix: Annotate data-race of sk->sk_state in unix_inq_len().
      af_unix: Annotate data-races around sk->sk_state in unix_write_space() and poll().
      af_unix: Annotate data-race of sk->sk_state in unix_stream_connect().
      af_unix: Annotate data-race of sk->sk_state in unix_accept().
      af_unix: Annotate data-races around sk->sk_state in sendmsg() and recvmsg().
      af_unix: Annotate data-race of sk->sk_state in unix_stream_read_skb().
      af_unix: Annotate data-races around sk->sk_state in UNIX_DIAG.
      af_unix: Annotate data-races around sk->sk_sndbuf.
      af_unix: Annotate data-race of net->unx.sysctl_max_dgram_qlen.
      af_unix: Use unix_recvq_full_lockless() in unix_stream_connect().
      af_unix: Use skb_queue_empty_lockless() in unix_release_sock().
      af_unix: Use skb_queue_len_lockless() in sk_diag_show_rqlen().
      af_unix: Annotate data-race of sk->sk_shutdown in sk_diag_fill().

Lars Kellogg-Stedman (1):
      ax25: Fix refcount imbalance on inbound connections

Larysa Zaremba (3):
      ice: remove af_xdp_zc_qps bitmap
      ice: add flag to distinguish reset from .ndo_bpf in XDP rings config
      ice: map XDP queues to vectors in ice_vsi_map_rings_to_vectors()

Lin Ma (1):
      wifi: cfg80211: pmsr: use correct nla_get_uX functions

Lingbo Kong (2):
      wifi: mac80211: fix Spatial Reuse element size check
      wifi: mac80211: correctly parse Spatial Reuse Parameter Set element

Magnus Karlsson (2):
      Revert "xsk: Support redirect to any socket bound to the same umem"
      Revert "xsk: Document ability to redirect to any socket bound to the same umem"

Matthias Stocker (1):
      vmxnet3: disable rx data ring on dma allocation failure

Matthieu Baerts (NGI0) (3):
      selftests: net: lib: support errexit with busywait
      selftests: net: lib: avoid error removing empty netns name
      selftests: net: lib: set 'i' as local

Miri Korenblit (2):
      wifi: iwlwifi: mvm: don't initialize csa_work twice
      wifi: iwlwifi: mvm: check n_ssids before accessing the ssids

Mordechay Goodstein (1):
      wifi: iwlwifi: mvm: set properly mac header

Moshe Shemesh (1):
      net/mlx5: Stop waiting for PCI if pci channel is offline

Nicolas Escande (2):
      wifi: mac80211: mesh: Fix leak of mesh_preq_queue objects
      wifi: mac80211: mesh: init nonpeer_pm to active by default in mesh sdata

Paolo Abeni (1):
      Merge branch 'af_unix-fix-lockless-access-of-sk-sk_state-and-others-fields'

Peter Geis (1):
      MAINTAINERS: remove Peter Geis

Remi Pommarel (2):
      wifi: mac80211: Fix deadlock in ieee80211_sta_ps_deliver_wakeup()
      wifi: cfg80211: Lock wiphy in cfg80211_get_station

Sasha Neftin (1):
      igc: Fix Energy Efficient Ethernet support declaration

Shahar S Matityahu (1):
      wifi: iwlwifi: dbg_ini: move iwl_dbg_tlv_free outside of debugfs ifdef

Shaul Triebitz (1):
      wifi: iwlwifi: mvm: always set the TWT IE offset

Shay Drory (1):
      net/mlx5: Always stop health timer during driver removal

Su Hui (1):
      net: ethtool: fix the error condition in ethtool_get_phy_stats_ethtool()

Subbaraya Sundeep (1):
      octeontx2-af: Always allocate PF entries from low prioriy zone

Taehee Yoo (1):
      ionic: fix kernel panic in XDP_TX action

Thorsten Blum (1):
      bpf, devmap: Remove unnecessary if check in for loop

Tristram Ha (2):
      net: phy: micrel: fix KSZ9477 PHY issues after suspend/resume
      net: phy: Micrel KSZ8061: fix errata solution not taking effect problem

Vadim Fedorenko (1):
      ethtool: init tsinfo stats if requested

Wen Gu (1):
      net/smc: avoid overwriting when adjusting sock bufsizes

Yedidya Benshimol (2):
      wifi: iwlwifi: mvm: d3: fix WoWLAN command version lookup
      wifi: iwlwifi: mvm: Handle BIGTK cipher in kek_kck cmd

 Documentation/networking/af_xdp.rst                |  31 ++---
 MAINTAINERS                                        |   1 -
 drivers/net/ethernet/intel/ice/ice.h               |  44 +++++--
 drivers/net/ethernet/intel/ice/ice_base.c          |   3 +
 drivers/net/ethernet/intel/ice/ice_lib.c           |  29 ++---
 drivers/net/ethernet/intel/ice/ice_main.c          | 144 ++++++++++++---------
 drivers/net/ethernet/intel/ice/ice_nvm.c           | 116 +++++++++++++++--
 drivers/net/ethernet/intel/ice/ice_type.h          |  14 +-
 drivers/net/ethernet/intel/ice/ice_xsk.c           |  13 +-
 drivers/net/ethernet/intel/igc/igc_ethtool.c       |   9 +-
 drivers/net/ethernet/intel/igc/igc_main.c          |   4 +
 .../net/ethernet/marvell/octeontx2/af/rvu_npc.c    |  33 +++--
 drivers/net/ethernet/mediatek/mtk_eth_soc.c        | 106 ++++++++++-----
 drivers/net/ethernet/mediatek/mtk_eth_soc.h        |   9 +-
 drivers/net/ethernet/mellanox/mlx5/core/fw.c       |   4 +
 drivers/net/ethernet/mellanox/mlx5/core/health.c   |   8 ++
 .../net/ethernet/mellanox/mlx5/core/lag/port_sel.c |   8 +-
 .../net/ethernet/mellanox/mlx5/core/lib/pci_vsc.c  |   4 +
 drivers/net/ethernet/mellanox/mlx5/core/main.c     |   3 +
 drivers/net/ethernet/pensando/ionic/ionic_txrx.c   |   1 +
 drivers/net/phy/micrel.c                           | 104 ++++++++++++++-
 drivers/net/virtio_net.c                           |  42 +++---
 drivers/net/vmxnet3/vmxnet3_drv.c                  |   2 +-
 drivers/net/vxlan/vxlan_core.c                     |   8 +-
 drivers/net/wireless/ath/ath10k/Kconfig            |   1 +
 drivers/net/wireless/ath/ath11k/core.c             |   2 +-
 drivers/net/wireless/ath/ath11k/mac.c              |  38 ++++--
 drivers/net/wireless/ath/ath11k/pcic.c             |  25 ++--
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c       |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c        |  16 ++-
 drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c   |   9 ++
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c        |  14 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c  |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c  |  39 +++++-
 .../net/wireless/intel/iwlwifi/mvm/mld-mac80211.c  |   2 -
 drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c   |  13 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h       |   1 +
 drivers/net/wireless/intel/iwlwifi/mvm/rs.h        |   9 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c      |   5 +-
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c      |  12 +-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c       |  12 +-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.h       |   5 +
 drivers/net/wireless/mediatek/mt76/mt7615/main.c   |   4 +
 drivers/net/wireless/microchip/wilc1000/cfg80211.c |  41 +++---
 drivers/net/wireless/microchip/wilc1000/hif.c      |  17 ++-
 drivers/net/wireless/microchip/wilc1000/netdev.c   |  43 +++---
 drivers/net/wireless/microchip/wilc1000/netdev.h   |  12 +-
 drivers/net/wireless/microchip/wilc1000/wlan.c     |   5 +-
 drivers/net/wireless/realtek/rtlwifi/core.c        |  15 ---
 drivers/net/wwan/iosm/iosm_ipc_devlink.c           |   2 +-
 drivers/ptp/ptp_chardev.c                          |   3 +-
 include/net/rtnetlink.h                            |   1 +
 include/net/tcp_ao.h                               |   7 +-
 kernel/bpf/devmap.c                                |   3 -
 kernel/bpf/syscall.c                               |  11 +-
 kernel/bpf/verifier.c                              |   4 +
 kernel/trace/bpf_trace.c                           |   2 -
 lib/test_rhashtable.c                              |   1 +
 net/ax25/af_ax25.c                                 |   6 +
 net/ax25/ax25_dev.c                                |   2 +-
 net/bpf/test_run.c                                 |   6 +
 net/core/dev.c                                     |   3 +-
 net/core/dst_cache.c                               |   2 +
 net/core/rtnetlink.c                               |  44 ++++++-
 net/ethtool/ioctl.c                                |   2 +-
 net/ethtool/tsinfo.c                               |   6 +-
 net/ipv4/devinet.c                                 |   2 +-
 net/ipv4/fib_frontend.c                            |   7 +-
 net/ipv4/tcp.c                                     |   9 +-
 net/ipv4/tcp_ao.c                                  |  13 +-
 net/ipv6/ila/ila_lwt.c                             |   7 +-
 net/ipv6/ioam6_iptunnel.c                          |   8 +-
 net/ipv6/ip6_fib.c                                 |   6 +-
 net/ipv6/route.c                                   |   1 +
 net/ipv6/rpl_iptunnel.c                            |  14 +-
 net/ipv6/seg6_iptunnel.c                           |  14 +-
 net/mac80211/cfg.c                                 |   9 +-
 net/mac80211/he.c                                  |  10 +-
 net/mac80211/ieee80211_i.h                         |   2 +
 net/mac80211/main.c                                |  10 +-
 net/mac80211/mesh.c                                |   1 +
 net/mac80211/mesh_pathtbl.c                        |  13 ++
 net/mac80211/parse.c                               |   2 +-
 net/mac80211/scan.c                                |  14 +-
 net/mac80211/sta_info.c                            |   4 +-
 net/mac80211/util.c                                |   2 +
 net/mptcp/protocol.c                               |   9 +-
 net/ncsi/internal.h                                |   2 +
 net/ncsi/ncsi-manage.c                             |  75 ++++++-----
 net/ncsi/ncsi-rsp.c                                |   4 +-
 net/sched/sch_multiq.c                             |   2 +-
 net/sched/sch_taprio.c                             |  15 +--
 net/smc/af_smc.c                                   |  22 +---
 net/unix/af_unix.c                                 |  90 +++++++------
 net/unix/diag.c                                    |  12 +-
 net/wireless/core.c                                |   2 +-
 net/wireless/pmsr.c                                |   8 +-
 net/wireless/rdev-ops.h                            |   6 +-
 net/wireless/scan.c                                |  50 ++++---
 net/wireless/sysfs.c                               |   4 +-
 net/wireless/util.c                                |   7 +-
 net/xdp/xsk.c                                      |   5 +-
 tools/lib/bpf/features.c                           |   3 +-
 .../selftests/bpf/progs/test_sk_storage_tracing.c  |   2 +-
 tools/testing/selftests/net/hsr/config             |   1 +
 tools/testing/selftests/net/lib.sh                 |  18 +--
 106 files changed, 1092 insertions(+), 582 deletions(-)

