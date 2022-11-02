Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF01E61620B
	for <lists+bpf@lfdr.de>; Wed,  2 Nov 2022 12:50:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbiKBLul (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Nov 2022 07:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiKBLuk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Nov 2022 07:50:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57AF928714
        for <bpf@vger.kernel.org>; Wed,  2 Nov 2022 04:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667389779;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=06VWUZSI6Qm+q2bw86oGTZUBRk/gldRyN2LaxznNUAc=;
        b=QJSj1eZNJTTzuF3FQ16UcnzUX1ZsJh3RWx3hstp9KUWOyTB8zgm4KDQh8ypr4Unahd+NaF
        +c1i53c8QYQ4Ko8FCDjvk4UV/kgWu44dXXFwZ0Afzru1H3pjhxTx9T60toFueB7HoO3Jp6
        4OtcYNnvWUenvRv4gpp64pVia/Ps3OQ=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-283-UJDp-NTcP1eMOZz03WUiKw-1; Wed, 02 Nov 2022 07:49:38 -0400
X-MC-Unique: UJDp-NTcP1eMOZz03WUiKw-1
Received: by mail-qv1-f69.google.com with SMTP id d8-20020a0cfe88000000b004bb65193fdcso9709198qvs.12
        for <bpf@vger.kernel.org>; Wed, 02 Nov 2022 04:49:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=06VWUZSI6Qm+q2bw86oGTZUBRk/gldRyN2LaxznNUAc=;
        b=ccJPrq2+DxtFb/ieA7uRMen5WpKCvTZ7OR5lsy4OXNxevS6G7DT6bt/Qmg59pmpPDg
         Bdx8X9/GvpAM1W5RioKcYMIbx7X6za3nki7cN8DnTENFoAxnzHrNJBFj2qKyE9RBwAoM
         PiTAi7/K1B809huS++M8H3URBGWrCr6HiUrWIxGkwDVyNOelrXYHLvZXhBprKzhc6fsq
         A6l2XZutYULOYbeb17jnzNcr1GSR3gUfT1pAMwNNGQLlek7UKEoYfFwQrMoyHfstNvqQ
         2t9D2OjWtCu1+aU/8TXWQ40G3e+cr4osJ16wH5lRl9VDtE7PaPuKa5OmOxqItUxfi/Sm
         xASw==
X-Gm-Message-State: ACrzQf24XhJg9Z3ZU6bFgqjqFjGy61ICGwYAp1167XPEYsZ+hexGJXWM
        nWzB9aeHjRzgmR8c+GENNZmX+4kb71r0r5OhoY4PbioqsMVH/65fUVh6Zw18qSH8U0AY8PXX1Xs
        hoHy9ntLRsReQ5HjSx6SH69foFjwQbpu9RgdeD0aQJn+OjaMSdj5jxGoKiTN1nvg=
X-Received: by 2002:a05:622a:1e05:b0:3a5:460f:9655 with SMTP id br5-20020a05622a1e0500b003a5460f9655mr1498353qtb.471.1667389777838;
        Wed, 02 Nov 2022 04:49:37 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4DJxHdfEPTbBpgqYZxtb6t994NR8WH5p2zFWigdLBnpc2oW+fMr6IzeXsMdnA/biKQcgrwPA==
X-Received: by 2002:a05:622a:1e05:b0:3a5:460f:9655 with SMTP id br5-20020a05622a1e0500b003a5460f9655mr1498334qtb.471.1667389777564;
        Wed, 02 Nov 2022 04:49:37 -0700 (PDT)
Received: from nfvsdn-06.testing.baremetal.edge-sites.net (nat-pool-232-132.redhat.com. [66.187.232.132])
        by smtp.gmail.com with ESMTPSA id h6-20020a05620a400600b006ee8874f5fasm7784855qko.53.2022.11.02.04.49.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 04:49:37 -0700 (PDT)
From:   mtahhan@redhat.com
To:     bpf@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     jbrouer@redhat.com, thoiland@redhat.com,
        Maryam Tahhan <mtahhan@redhat.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH bpf-next v2 0/1] docs: BPF_MAP_TYPE_CPUMAP
Date:   Wed,  2 Nov 2022 08:44:15 -0400
Message-Id: <20221102124416.2820268-1-mtahhan@redhat.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Maryam Tahhan <mtahhan@redhat.com>

Add documentation for BPF_MAP_TYPE_CPUMAP including
kernel version introduced, usage and examples.

Signed-off-by: Maryam Tahhan <mtahhan@redhat.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>

v2:
- Removed TMI.
- Updated example to use a round robin scheme.

Maryam Tahhan (1):
  docs: BPF_MAP_TYPE_CPUMAP

 Documentation/bpf/map_cpumap.rst | 140 +++++++++++++++++++++++++++++++
 1 file changed, 140 insertions(+)
 create mode 100644 Documentation/bpf/map_cpumap.rst

-- 
2.35.3

