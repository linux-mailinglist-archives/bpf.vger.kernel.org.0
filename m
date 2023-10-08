Return-Path: <bpf+bounces-11652-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA067BCC46
	for <lists+bpf@lfdr.de>; Sun,  8 Oct 2023 07:22:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF640281F42
	for <lists+bpf@lfdr.de>; Sun,  8 Oct 2023 05:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC5C84404;
	Sun,  8 Oct 2023 05:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="jPWsjLVm"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4BF17F3
	for <bpf@vger.kernel.org>; Sun,  8 Oct 2023 05:22:02 +0000 (UTC)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7210C5
	for <bpf@vger.kernel.org>; Sat,  7 Oct 2023 22:21:58 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6934202b8bdso2896945b3a.1
        for <bpf@vger.kernel.org>; Sat, 07 Oct 2023 22:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1696742518; x=1697347318; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DgD4r836oY8il5pow7srv4opCapu6nh2l3q+eKJTpwk=;
        b=jPWsjLVmjPoJXH5gmKOl9BO0YnAjnGZ+6sZRp3+TYR6guDbp7niGknO+T/JnCR6XU0
         /uTrf8BQYTvjAaSwMNnnPcNFXtB1o/npRHJR66D/ez8PT8LwQixuXXgIUUb3sEFwG9Bk
         XWxQCbIdgdCnbOKCPqSFd3IsZgvSYQD4cXdSpfUyY+W9KYIfpclprHKyxMlYQdkwun52
         r97C8U/2bvGj7cDgWLt8+QHQp4lMkUmeycupifgQZa+xX9YqKhkMxv9TA/Ws98zCydvo
         CsrxivQuvskuasn2T7XCm5J+ZrB6wt5VEQV5B0V/ZetZcm0J+gGRaER+ZwObu7Wb+F51
         TWMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696742518; x=1697347318;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DgD4r836oY8il5pow7srv4opCapu6nh2l3q+eKJTpwk=;
        b=cz1OOcFjQA8Bp/LqERfTt59NiimSQHPeod82pAJ1giPZYfGiWzk8/VO3P4hNz3AMF0
         Kt0yBfsT3tsdgLVI6Q10DBy3Zx62Q+br4VEeK9MYvIbw4KVL6CQAq2HbcIS83zoOFLOy
         Ov2dxrGFEPHOYBjeiGSZ69TUjMWSQrYzYMw7L//aHhRoYhRNJ9XGqq1MIpdJp+4xmdvV
         XQMxnJRFyYmqx667g7uTlEDlWgwakUZSp5tMlF3KGYnFfx6d3teorV/DsJMAd500QVkx
         MmzJO5W9mpBjVZsP6viOaYAfm0hovIQ3TQCr6xkeA1mYXUnF/cKt4GOPRv7fv+zWmZ8s
         zXlw==
X-Gm-Message-State: AOJu0YywGprNxCKIKskYHY/DWhDAyefXGMPl4FA97o30ew8A/0EMnROy
	WwkmZ/VQUuo8fSpECOAXagKrig==
X-Google-Smtp-Source: AGHT+IElzJDKhSP5+1HhaFmGAgJ0ftTEht+DvZQJIrdcieZu+1SLgGBYvkerJg4+UYKYs8eY+FBykA==
X-Received: by 2002:a05:6a00:22c9:b0:690:2ecd:a593 with SMTP id f9-20020a056a0022c900b006902ecda593mr15590201pfj.26.1696742518103;
        Sat, 07 Oct 2023 22:21:58 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
        by smtp.gmail.com with UTF8SMTPSA id r5-20020a62e405000000b006933b69f7afsm3947684pfh.42.2023.10.07.22.21.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Oct 2023 22:21:57 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowang@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Xuan Zhuo Shuah Khan <"xuanzhuo@linux.alibaba.comshuah"@kernel.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
	linux-kselftest@vger.kernel.org, bpf@vger.kernel.org,
	davem@davemloft.net, kuba@kernel.org, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, kafai@fb.com,
	songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
	kpsingh@kernel.org, rdunlap@infradead.org, willemb@google.com,
	gustavoars@kernel.org, herbert@gondor.apana.org.au,
	steffen.klassert@secunet.com, nogikh@google.com, pablo@netfilter.org,
	decui@microsoft.com, cai@lca.pw, jakub@cloudflare.com,
	elver@google.com, pabeni@redhat.com,
	Yuri Benditovich <yuri.benditovich@daynix.com>,
	Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [RFC PATCH 0/7] tun: Introduce virtio-net hashing feature
Date: Sun,  8 Oct 2023 14:20:44 +0900
Message-ID: <20231008052101.144422-1-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

virtio-net have two usage of hashes: one is RSS and another is hash
reporting. Conventionally the hash calculation was done by the VMM.
However, computing the hash after the queue was chosen defeats the
purpose of RSS.

Another approach is to use eBPF steering program. This approach has
another downside: it cannot report the calculated hash due to the
restrictive nature of eBPF.

Introduce the code to compute hashes to the kernel in order to overcome
thse challenges.

An alternative solution is to extend the eBPF steering program so that it
will be able to report to the userspace, but it makes little sense to
allow to implement different hashing algorithms with eBPF since the hash
value reported by virtio-net is strictly defined by the specification.
An implementation of this alternative solution was submitted as RFC
patches in the past:
https://lore.kernel.org/lkml/20210112194143.1494-1-yuri.benditovich@daynix.com/

QEMU patched to use this new feature is available at:
https://github.com/daynix/qemu/tree/akihikodaki/rss

The QEMU patches will soon be submitted to the upstream as RFC too.

Akihiko Odaki (7):
  net: skbuff: Add tun_vnet_hash flag
  net/core: Ensure qdisc_skb_cb will not be overwritten
  net: sched: Add members to qdisc_skb_cb
  virtio_net: Add functions for hashing
  tun: Introduce virtio-net hashing feature
  selftest: tun: Add tests for virtio-net hashing
  vhost_net: Support VIRTIO_NET_F_HASH_REPORT

 drivers/net/tun.c                    | 187 ++++++++-
 drivers/vhost/net.c                  |  16 +-
 include/linux/skbuff.h               |   2 +
 include/linux/virtio_net.h           | 157 ++++++++
 include/net/sch_generic.h            |  12 +-
 include/uapi/linux/if_tun.h          |  16 +
 net/core/dev.c                       |   1 +
 tools/testing/selftests/net/Makefile |   2 +-
 tools/testing/selftests/net/tun.c    | 578 ++++++++++++++++++++++++++-
 9 files changed, 933 insertions(+), 38 deletions(-)

-- 
2.42.0


