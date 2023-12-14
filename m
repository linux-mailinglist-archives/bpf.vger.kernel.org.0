Return-Path: <bpf+bounces-17767-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EAFA8124EB
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 03:05:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC999280C64
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 02:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D46EC7;
	Thu, 14 Dec 2023 02:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DkHmqonU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E18E3
	for <bpf@vger.kernel.org>; Wed, 13 Dec 2023 18:05:37 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-dbcda5ef8daso965266276.3
        for <bpf@vger.kernel.org>; Wed, 13 Dec 2023 18:05:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702519536; x=1703124336; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+ronbOySVVJCeCFXE+E452YTaKGaTM58JCsYafTPHk4=;
        b=DkHmqonUytnYF2oN/aGhCb13hqOLBVcsnUgMBwRHn3risdLIOysKUH+t8sDqud79zu
         K6rRA7CpcP1LSQUqdJ5N58ZLzTC3GsgLdi82mftGk8ZD9TkJ13Mao81gr5Wun5Y9o3v7
         SLnl9pzl+5+Qk0dEqwfQXxz0WntaFts4guHWfXp5Ng1gzNsnZa1w/jSEJagKb+Z50LMc
         PvTrtmqu/cHBXlVoRRHTu47w1DAX4ek3nUfTCmaj197cQtx+AD/0QptT1bsIokQki8C7
         e7B47lCJ3HjRTzTwy6HxdFljYpvKmrKqDWPqLoL2HH/SwWUD5hqKq2ohojVabEn6cChB
         ilIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702519536; x=1703124336;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+ronbOySVVJCeCFXE+E452YTaKGaTM58JCsYafTPHk4=;
        b=mcMwYZgDyz0TET6L1M835vi1ct9SgHUc/Km3AujI1BhgS5FO+ZTmd6KpfM2W88ATHK
         XVItURYng1FWUvhkV8LfWuHVR5S3GJH5BV1GKm8/e/VmJvv0weVOKl6/+5rwGxgxchJj
         DMMoC9TjQ78Hax0wvqwNOYEXXgK+1jGm1a7z6Xdv0A+h+oAFyF8YCPGGqMuTV3HXplUT
         kwtsw8SSnV9UBM9EuTGrMXeIUkbDg5jUpyvdkn9PZoG+PUPOa+EdOjk82mvuONQkEMHC
         EeaJASMe4RwYRjWKxCMe3KNn3bpomaxKyWthLwny/rCjPs+PJoF6HRO9auv2XaAIWLcU
         EAtg==
X-Gm-Message-State: AOJu0Yyl6bjbv630XyGZ+mHV5xgMGoqJuScba7OzfKxkipXAApC7HwyF
	H4GGmbP5M7YNqdHoVmR8ai6KT/081HhtgMZJqw==
X-Google-Smtp-Source: AGHT+IGncV41fwbhz/mCy6hSR3EOohDoL5eRhnTHrk4bhzSdLjyeCnLJseqiKf/w0iEIyiWoDGOSz2aVqCYno2zrog==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2c4:200:d31b:c1a:fb6a:2488])
 (user=almasrymina job=sendgmr) by 2002:a05:6902:545:b0:dbc:e64a:ccd6 with
 SMTP id z5-20020a056902054500b00dbce64accd6mr1821ybs.9.1702519536540; Wed, 13
 Dec 2023 18:05:36 -0800 (PST)
Date: Wed, 13 Dec 2023 18:05:24 -0800
In-Reply-To: <20231214020530.2267499-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231214020530.2267499-1-almasrymina@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231214020530.2267499-2-almasrymina@google.com>
Subject: [RFC PATCH net-next v1 1/4] vsock/virtio: use skb_frag_page() helper
From: Mina Almasry <almasrymina@google.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>, 
	"=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>, Michael Chan <michael.chan@broadcom.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Wei Fang <wei.fang@nxp.com>, 
	Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, 
	NXP Linux Team <linux-imx@nxp.com>, Jeroen de Borst <jeroendb@google.com>, 
	Praveen Kaligineedi <pkaligineedi@google.com>, Shailend Chand <shailend@google.com>, 
	Yisen Zhuang <yisen.zhuang@huawei.com>, Salil Mehta <salil.mehta@huawei.com>, 
	Jesse Brandeburg <jesse.brandeburg@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Marcin Wojtas <mw@semihalf.com>, 
	Russell King <linux@armlinux.org.uk>, Sunil Goutham <sgoutham@marvell.com>, 
	Geetha sowjanya <gakula@marvell.com>, Subbaraya Sundeep <sbhatta@marvell.com>, 
	hariprasad <hkelam@marvell.com>, Felix Fietkau <nbd@nbd.name>, John Crispin <john@phrozen.org>, 
	Sean Wang <sean.wang@mediatek.com>, Mark Lee <Mark-MC.Lee@mediatek.com>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
	Horatiu Vultur <horatiu.vultur@microchip.com>, UNGLinuxDriver@microchip.com, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Jassi Brar <jaswinder.singh@linaro.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Siddharth Vadapalli <s-vadapalli@ti.com>, 
	Ravi Gunasekaran <r-gunasekaran@ti.com>, Roger Quadros <rogerq@kernel.org>, 
	Jiawen Wu <jiawenwu@trustnetic.com>, Mengyuan Lou <mengyuanlou@net-swift.com>, 
	Ronak Doshi <doshir@vmware.com>, VMware PV-Drivers Reviewers <pv-drivers@vmware.com>, 
	Ryder Lee <ryder.lee@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>, 
	Kalle Valo <kvalo@kernel.org>, Juergen Gross <jgross@suse.com>, 
	Stefano Stabellini <sstabellini@kernel.org>, 
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	"=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Shakeel Butt <shakeelb@google.com>, Yunsheng Lin <linyunsheng@huawei.com>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Minor fix for virtio: code wanting to access the page inside
the skb should use skb_frag_page() helper, instead of accessing
bv_page directly. This allows for extensions where the underlying
memory is not a page.

Signed-off-by: Mina Almasry <almasrymina@google.com>

---
 net/vmw_vsock/virtio_transport.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index af5bab1acee1..bd0b413dfa3f 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -153,7 +153,7 @@ virtio_transport_send_pkt_work(struct work_struct *work)
 				 * 'virt_to_phys()' later to fill the buffer descriptor.
 				 * We don't touch memory at "virtual" address of this page.
 				 */
-				va = page_to_virt(skb_frag->bv_page);
+				va = page_to_virt(skb_frag_page(skb_frag));
 				sg_init_one(sgs[out_sg],
 					    va + skb_frag->bv_offset,
 					    skb_frag->bv_len);
-- 
2.43.0.472.g3155946c3a-goog


