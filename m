Return-Path: <bpf+bounces-6233-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F8EC7673AD
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 19:44:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 852CD1C204F9
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 17:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BEAA16412;
	Fri, 28 Jul 2023 17:44:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69BC156E8;
	Fri, 28 Jul 2023 17:44:32 +0000 (UTC)
Received: from mgamail.intel.com (unknown [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 276ED10CB;
	Fri, 28 Jul 2023 10:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690566271; x=1722102271;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GKGOawcn7PhFz576lPTLK52fr6rLUl41RfHTjbVuL+U=;
  b=Fg77TJvZGN5c01i1na0VLzmJ7jJ9LyfWrWwoGgmG9OBpRnVKepa6vER5
   YYW/ii4D4B7+Npa8aAJXEwhhH/uRGCAMxDgnl3ZARMleZkoT5D5DGAPUT
   NPDtMx/xGDQ0O5RO1HTjVBKZeOyS+Lqn3qJSNxcEp4IcF4jqEtnlOLA8+
   uCe3s1j0L/fCuAgdYcj6vOMODqJ8FqtuDf/IAf5WfGGQaMY45r0E1+bRm
   0ROe2a9AHmW0P6CPQL8rUpqwprDNeuBlXylZX70aQ0dChKk5pPxqBD3VY
   LuAho8XYFcEDWJbuOE20ch10DB80d8GspU3utgtOdrNOFZIqSaHhbWhS/
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="366117240"
X-IronPort-AV: E=Sophos;i="6.01,238,1684825200"; 
   d="scan'208";a="366117240"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2023 10:44:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="851294512"
X-IronPort-AV: E=Sophos;i="6.01,238,1684825200"; 
   d="scan'208";a="851294512"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orsmga004.jf.intel.com with ESMTP; 28 Jul 2023 10:43:57 -0700
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 6D5C237E1F;
	Fri, 28 Jul 2023 18:43:55 +0100 (IST)
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: bpf@vger.kernel.org
Cc: Larysa Zaremba <larysa.zaremba@intel.com>,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yhs@fb.com,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	David Ahern <dsahern@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Jesper Dangaard Brouer <brouer@redhat.com>,
	Anatoly Burakov <anatoly.burakov@intel.com>,
	Alexander Lobakin <alexandr.lobakin@intel.com>,
	Magnus Karlsson <magnus.karlsson@gmail.com>,
	Maryam Tahhan <mtahhan@redhat.com>,
	xdp-hints@xdp-project.net,
	netdev@vger.kernel.org,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Simon Horman <simon.horman@corigine.com>
Subject: 
Date: Fri, 28 Jul 2023 19:39:02 +0200
Message-ID: <20230728173923.1318596-1-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Date: Fri, 28 Jul 2023 19:10:32 +0200
Subject: [PATCH bpf-next v4 00/21] XDP metadata via kfuncs for ice
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series introduces XDP hints via kfuncs [0] to the ice driver.

Series brings the following existing hints to the ice driver:
 - HW timestamp
 - RX hash with type

Series also introduces new hints and adds their implementation
to ice and veth:
 - VLAN tag with protocol
 - Checksum status

The data above can now be accessed by XDP and userspace (AF_XDP) programs.
They can also be checked with xdp_metadata test and xdp_hw_metadata program.

[0] https://patchwork.kernel.org/project/netdevbpf/cover/20230119221536.3349901-1-sdf@google.com/

v3:
https://lore.kernel.org/bpf/20230719183734.21681-1-larysa.zaremba@intel.com/
v2:
https://lore.kernel.org/bpf/20230703181226.19380-1-larysa.zaremba@intel.com/
v1:
https://lore.kernel.org/all/20230512152607.992209-1-larysa.zaremba@intel.com/

Changes since v3:
- use XDP_CHECKSUM_VALID_LVL0 + csum_level instead of csum_level + 1
- fix spelling mistakes
- read XDP timestamp unconditionally
- add TO_STR() macro

Changes since v2:
- redesign checksum hint, so now it gives full status
- rename vlan_tag -> vlan_tci, where applicable
- use open_netns() and close_netns() in xdp_metadata
- improve VLAN hint documentation
- replace CFI with DEI
- use VLAN_VID_MASK in xdp_metadata
- make vlan_get_tag() return -ENODATA
- remove unused rx_ptype in ice_xsk.c
- fix ice timestamp code division between patches

Changes since v1:
- directly return RX hash, RX timestamp and RX checksum status
  in skb-common functions
- use intermediate enum value for checksum status in ice
- get rid of ring structure dependency in ice kfunc implementation
- make variables const, when possible, in ice implementation
- use -ENODATA instead of -EOPNOTSUPP for driver implementation
- instead of having 2 separate functions for c-tag and s-tag,
  use 1 function that outputs both VLAN tag and protocol ID
- improve documentation for introduced hints
- update xdp_metadata selftest to test new hints
- implement new hints in veth, so they can be tested in xdp_metadata
- parse VLAN tag in xdp_hw_metadata

Aleksander Lobakin (1):
  net, xdp: allow metadata > 32

Larysa Zaremba (17):
  ice: make RX hash reading code more reusable
  ice: make RX HW timestamp reading code more reusable
  ice: make RX checksum checking code more reusable
  ice: Make ptype internal to descriptor info processing
  ice: Introduce ice_xdp_buff
  ice: Support HW timestamp hint
  ice: Support RX hash XDP hint
  ice: Support XDP hints in AF_XDP ZC mode
  xdp: Add VLAN tag hint
  ice: Implement VLAN tag hint
  ice: use VLAN proto from ring packet context in skb path
  xdp: Add checksum hint
  ice: Implement checksum hint
  selftests/bpf: Allow VLAN packets in xdp_hw_metadata
  selftests/bpf: Add flags and new hints to xdp_hw_metadata
  veth: Implement VLAN tag and checksum XDP hint
  net: make vlan_get_tag() return -ENODATA instead of -EINVAL

Yonghong Song (3):
  docs/bpf: Add documentation for new instructions
  bpf: Fix compilation warning with -Wparentheses
  selftests/bpf: Enable test test_progs-cpuv4 for gcc build kernel

-- 
2.41.0


