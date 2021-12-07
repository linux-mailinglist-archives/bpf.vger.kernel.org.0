Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7757646BCA0
	for <lists+bpf@lfdr.de>; Tue,  7 Dec 2021 14:31:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232547AbhLGNeq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Dec 2021 08:34:46 -0500
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:47611 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232505AbhLGNep (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 7 Dec 2021 08:34:45 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 485BA580169;
        Tue,  7 Dec 2021 08:31:15 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 07 Dec 2021 08:31:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dtucker.co.uk;
         h=from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm1; bh=YfwIM/Lk5oHhwshP/rQHys5GU+
        ie4/b45j1GmoWHTuE=; b=ZETQjVbxtwrK5jkF3RoGvN1b40RdIkYHDmUpNF6/qz
        wNZkEhoWxsSNQw5Zji3jkipyUfZTb+GujKkFzicpB+oCyHXfcXKcAeUGI1DI8NcC
        Xh1c3JmDAJ7u9+J96rLI8/oquN6AQSpM7SwIPUhCSCMyr79WT/dHGbr0OjEb3shN
        joz8yJoX5ckk/TfE2eCbLGU0w2/ESjTARC0uIvCsVk7+RTSprCPmFZW3K7Bz0pM5
        e8z+6pvHBjWJrQYzRKA+7xzsPFkzadjLhEfMd9uKPX+q3fB7QpA4Sh/lPo4+G3bO
        6PVx4gza29LZinmSbQXMI6eYDKZwm+ja+V/zBq7FvJIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=YfwIM/Lk5oHhwshP/
        rQHys5GU+ie4/b45j1GmoWHTuE=; b=FA4zCvULKHfFZvUmV1gzI71hgsJbXlbjG
        zLta+JRjOho591+uShPvO3QSDY2GLWsdz76ajZhAM246Ok0ayjm6PoRxH26cs3J4
        urUnJtArXvaH8FaY4fIj/bMQd6fCc2qSBS39jrA5aJBa4lwNLNL5+x37BciWHf4b
        X697AWmjzV/xpMtK6olEVFmLFktETiLhEX1TPeyYPvGzqHvpeuWWJzB3+ySUX/eA
        rWRGzpXiTxWwsW8+8N1fz+feCRTpbiWaxLB4bamFwD2y9TmgcgwLiGeIu9i9UmDy
        KeSXFvrcZfkN8I0ecJNt/A/PvTJRhC8XoKQsDUm8CVXl1oljy6zzA==
X-ME-Sender: <xms:I2KvYY1iKeAEfBKW2qLwd-iimHhC2tV79oB8B3w4wJODGYA3UhjQXQ>
    <xme:I2KvYTHAGwjP3SC_a5b1vFr8HOB0S_IJIShDoXjs52TWe9Pop0f_iCc18etWFg2R5
    FtVvD415xo1C_IUEg>
X-ME-Received: <xmr:I2KvYQ4zCQWSNuiirl2MhAxoH6bUXUlTLtzVVnT8jNnzLswZWDaqouCtXQM5Ty-l4ZjlyDMw9g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrjeehgdehgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertdertd
    dtnecuhfhrohhmpeffrghvvgcuvfhutghkvghruceouggrvhgvseguthhutghkvghrrdgt
    ohdruhhkqeenucggtffrrghtthgvrhhnpeefvddtueelfefhuedtgfevfefhgedvkeegud
    etvdfgueekudehtefghefhkeduudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpegurghvvgesughtuhgtkhgvrhdrtghordhukh
X-ME-Proxy: <xmx:I2KvYR29lOIYzgLHvR8WRLR4ToOAUuNnOWBUIpAQqLnkUKRAFYZzrg>
    <xmx:I2KvYbFXPNSPM_uzd7HPbGdltdZO9TKqsiuIJVQoH_11hV3kmnSQGw>
    <xmx:I2KvYa_4jGr5S9FX1LRcwBOkZhhiPcDI9z5lsJFLxYujzkP2h3beIA>
    <xmx:I2KvYSBfd19d4QEb-dOOoa7uE7jyw5Y_M1_fIpwp8tKIacUzH1MYsA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Dec 2021 08:31:14 -0500 (EST)
From:   Dave Tucker <dave@dtucker.co.uk>
To:     bpf@vger.kernel.org
Cc:     corbet@lwn.net, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kafai@fb.com, songliubraving@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        linux-doc@vger.kernel.org, Dave Tucker <dave@dtucker.co.uk>
Subject: [PATCH v3 bpf-next 0/2] bpf, docs: Document BPF_MAP_TYPE_ARRAY
Date:   Tue,  7 Dec 2021 13:31:09 +0000
Message-Id: <cover.1638883067.git.dave@dtucker.co.uk>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This series is the beginning of my attempt to improve the BPF map and
program type documentation. It expands the template from
map_cgroup_storage to include the kernel version it was introduced.
I then used this template to document BPF_MAP_TYPE_ARRAY and
BPF_MAP_TYPE_PERCPU_ARRAY

v2->v3:
- wrap text to 80 chars and add newline at end of file

v1->v2:
- point to selftests for functional examples
- update examples to follow kernel style
- add docs for BPF_F_MMAPABLE

Dave Tucker (2):
  bpf, docs: add kernel version to map_cgroup_storage
  bpf, docs: document BPF_MAP_TYPE_ARRAY

 Documentation/bpf/map_array.rst          | 182 +++++++++++++++++++++++
 Documentation/bpf/map_cgroup_storage.rst |   2 +
 2 files changed, 184 insertions(+)
 create mode 100644 Documentation/bpf/map_array.rst

-- 
2.33.1

