Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB0F46A8178
	for <lists+bpf@lfdr.de>; Thu,  2 Mar 2023 12:46:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbjCBLqb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Mar 2023 06:46:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjCBLqa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Mar 2023 06:46:30 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51C7322023;
        Thu,  2 Mar 2023 03:46:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677757590; x=1709293590;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Rwzg5qdpMDInEamKvu59F/cSMfhKuzbKRtA6KgE8UEo=;
  b=hYtillWoL49UTPD9Zf+VLkuGvL41NxCXbQZ0MwZpFtKdyINpuCVnBAAi
   EWtoVwgqDVl5uOu0Dg29R8xsiEUUQfYajauaT1Fzq8Yl6Xcs/CELrB7oL
   lT1D1a3gHLlj1rxuOISb/A/MfGjOkogaU464vSVWhl23rAI43W3XzkrVH
   wPxB6nc89IdOlf8MNzon6nUSDuDXc8rMsHT2ajFlMzYeuSVY3+myUB3Vh
   1Daau8te3nLQBu78bLE/UbfRPvTw9OVKCIYnA0zfCPXYjhnHUgeAPK4Gl
   5tgI048UYH6q3/UlOLBrzfUNQATX8S+dUSYx4eH0KalRi71NMtkC385p7
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="332180125"
X-IronPort-AV: E=Sophos;i="5.98,227,1673942400"; 
   d="scan'208";a="332180125"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2023 03:46:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="705229329"
X-IronPort-AV: E=Sophos;i="5.98,227,1673942400"; 
   d="scan'208";a="705229329"
Received: from pplank-mobl1.ger.corp.intel.com (HELO tkristo-desk.bb.dnainternet.fi) ([10.251.217.71])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2023 03:46:27 -0800
From:   Tero Kristo <tero.kristo@linux.intel.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        bpf@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCHv2 0/2] bpf: Absolute timer support
Date:   Thu,  2 Mar 2023 13:46:12 +0200
Message-Id: <20230302114614.2985072-1-tero.kristo@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

v2 of this series just adds the selftest support. Patch #1 is modified
slightly (bpf.h modified under tools/include) so that the new selftest
compiles properly. I also added suggested-by tag from Artem whom I
forgot to add in the initial upstream post.

-Tero


