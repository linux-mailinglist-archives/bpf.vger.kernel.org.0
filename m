Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17F4251860F
	for <lists+bpf@lfdr.de>; Tue,  3 May 2022 16:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235092AbiECOI2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 3 May 2022 10:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236230AbiECOIZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 3 May 2022 10:08:25 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A74F532EFB
        for <bpf@vger.kernel.org>; Tue,  3 May 2022 07:04:52 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1096067373; Tue,  3 May 2022 16:04:50 +0200 (CEST)
Date:   Tue, 3 May 2022 16:04:49 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     ast@kernel.org, daniel@iogearbox.net
Cc:     bpf@vger.kernel.org
Subject: LSF/MM session: eBPF standardization
Message-ID: <20220503140449.GA22470@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Alexei and Daniel,

if you have some time left I'd like to kick off a short discussion on
what to do about documenting and standardizing eBPF.
