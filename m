Return-Path: <bpf+bounces-13362-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A2B7D8AF7
	for <lists+bpf@lfdr.de>; Thu, 26 Oct 2023 23:56:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BCE2B21331
	for <lists+bpf@lfdr.de>; Thu, 26 Oct 2023 21:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 831393F4CD;
	Thu, 26 Oct 2023 21:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YPj55n2C"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D8C3E47E
	for <bpf@vger.kernel.org>; Thu, 26 Oct 2023 21:56:19 +0000 (UTC)
Received: from mail-oi1-x24a.google.com (mail-oi1-x24a.google.com [IPv6:2607:f8b0:4864:20::24a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90B4E1AD
	for <bpf@vger.kernel.org>; Thu, 26 Oct 2023 14:56:15 -0700 (PDT)
Received: by mail-oi1-x24a.google.com with SMTP id 5614622812f47-3b2ef9e4c25so2108234b6e.1
        for <bpf@vger.kernel.org>; Thu, 26 Oct 2023 14:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698357375; x=1698962175; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BGnfO5yo1brrl3JG1fuz3XeacVop9nGYIXct/GsCbHA=;
        b=YPj55n2CVrwECELqBp1BWiRdDeiahWrh09vlZ9y4NuNIM4rkt4JjSTqAD3G14/dtDN
         s9qy7TH1VNXFRWZRxvyV8chlR75DGWEb8DHwpyan3CMTpFapkWaO+0Vdbwaff7HzQotA
         2wsba9jbSdhe9m3ytUGelfD2m5nszW3EMaTmjhwE7kjyctQaGJ6wSpPY1JBk/8mOG4IK
         e0Lfr3qz3Krsqf3x0jI5dko8CEbdQ2TdfXUaIyhK86nUQpuN36EuhYopTbPE+gGu2CYu
         kqY2vs8KI8byVCUOC064QBGruHUGWvdsrbkg7r9XFBZpMXhKyWNgBjL0Pb4SEaK2emWS
         v6SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698357375; x=1698962175;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BGnfO5yo1brrl3JG1fuz3XeacVop9nGYIXct/GsCbHA=;
        b=vlGGkEQPMtQd70aQpnERO4aWtbbEz90Erv8/lNngPiyw2E+ZI7Cph1FuHciuOnS6cj
         2+Q7T2yVgKoJypOjzjPgJm1qeJ5dm3SWxqrrwIZMV82aqCR9nrCJwDq/ROwJvreRx5vU
         mgv7KWyFnFfhbKow2gvIOzFepqmpFWhYObUHa5XsmvrGIBioJpSO+PDkc2+qoycxll4C
         IGIlFKo2gzloHLmLStzzh6vc4ihjTaE5hLJzL6mi6TDhUC/JYF7XQ08JTcEy98BdRIel
         +9gstvZslyaz1QfILHfb7ge7Kd15v/G83cQDxo2ITwnbaIT1Y/mVO3Rk7zM99RDqXA2I
         NdUA==
X-Gm-Message-State: AOJu0Yz8jOBba4Q1SRc5xrDh7aG/tuFeTvYLMHo7DT8yd4K4PfO0aSU6
	Ugxebt1m4fp5epYRmSu+geM7kFPh2d/WVm6Bqg==
X-Google-Smtp-Source: AGHT+IF5gOPekjq4+QDN3pBVLuKGKeKe6H18GFsh2OoUyXeyiM7MMvJg4zKShMICsysc3GRHujvfELlFaE0x7zGmTQ==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6808:f01:b0:3ad:f860:b315 with
 SMTP id m1-20020a0568080f0100b003adf860b315mr220107oiw.2.1698357374848; Thu,
 26 Oct 2023 14:56:14 -0700 (PDT)
Date: Thu, 26 Oct 2023 21:56:07 +0000
In-Reply-To: <20231026-ethtool_puts_impl-v2-0-0d67cbdd0538@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231026-ethtool_puts_impl-v2-0-0d67cbdd0538@google.com>
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1698357372; l=2655;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=8djdPmMRDp1kcBXDhs8ygPXLuTfgtvGs7Yo95u6cw0k=; b=oxdmPg9KABeZlWyohpoRER6suttzISQsU1pFrM2utjhSx+ViWnRXf8IVNcElP/r+ITJcWQj9E
 seeyc13ojC5BXu0aQZG5KcerhesMEYloY+EmDxWK7pulBdKUNUGMRBN
X-Mailer: b4 0.12.3
Message-ID: <20231026-ethtool_puts_impl-v2-1-0d67cbdd0538@google.com>
Subject: [PATCH next v2 1/3] ethtool: Implement ethtool_puts()
From: Justin Stitt <justinstitt@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shay Agroskin <shayagr@amazon.com>, 
	Arthur Kiyanovski <akiyano@amazon.com>, David Arinzon <darinzon@amazon.com>, Noam Dagan <ndagan@amazon.com>, 
	Saeed Bishara <saeedb@amazon.com>, Rasesh Mody <rmody@marvell.com>, 
	Sudarsana Kalluru <skalluru@marvell.com>, GR-Linux-NIC-Dev@marvell.com, 
	Dimitris Michailidis <dmichail@fungible.com>, Yisen Zhuang <yisen.zhuang@huawei.com>, 
	Salil Mehta <salil.mehta@huawei.com>, Jesse Brandeburg <jesse.brandeburg@intel.com>, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, Louis Peens <louis.peens@corigine.com>, 
	Shannon Nelson <shannon.nelson@amd.com>, Brett Creeley <brett.creeley@amd.com>, drivers@pensando.io, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Ronak Doshi <doshir@vmware.com>, 
	VMware PV-Drivers Reviewers <pv-drivers@vmware.com>, Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>, 
	Dwaipayan Ray <dwaipayanray1@gmail.com>, Lukas Bulwahn <lukas.bulwahn@gmail.com>, 
	Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>, 
	Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean <olteanv@gmail.com>, 
	"=?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?=" <arinc.unal@arinc9.com>, Daniel Golle <daniel@makrotopia.org>, 
	Landen Chao <Landen.Chao@mediatek.com>, DENG Qingfang <dqfext@gmail.com>, 
	Sean Wang <sean.wang@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Linus Walleij <linus.walleij@linaro.org>, 
	"=?utf-8?q?Alvin_=C5=A0ipraga?=" <alsi@bang-olufsen.dk>, Wei Fang <wei.fang@nxp.com>, 
	Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, 
	NXP Linux Team <linux-imx@nxp.com>, Lars Povlsen <lars.povlsen@microchip.com>, 
	Steen Hegelund <Steen.Hegelund@microchip.com>, Daniel Machon <daniel.machon@microchip.com>, 
	UNGLinuxDriver@microchip.com, Jiawen Wu <jiawenwu@trustnetic.com>, 
	Mengyuan Lou <mengyuanlou@net-swift.com>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	Nick Desaulniers <ndesaulniers@google.com>, Nathan Chancellor <nathan@kernel.org>, 
	Kees Cook <keescook@chromium.org>, intel-wired-lan@lists.osuosl.org, 
	oss-drivers@corigine.com, linux-hyperv@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	bpf@vger.kernel.org, Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"

Use strscpy() to implement ethtool_puts().

Functionally the same as ethtool_sprintf() when it's used with two
arguments or with just "%s" format specifier.

Signed-off-by: Justin Stitt <justinstitt@google.com>
---
 include/linux/ethtool.h | 34 +++++++++++++++++++++++-----------
 net/ethtool/ioctl.c     |  7 +++++++
 2 files changed, 30 insertions(+), 11 deletions(-)

diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index 226a36ed5aa1..7129dd2e227c 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -1053,22 +1053,34 @@ static inline int ethtool_mm_frag_size_min_to_add(u32 val_min, u32 *val_add,
  */
 extern __printf(2, 3) void ethtool_sprintf(u8 **data, const char *fmt, ...);
 
+/**
+ * ethtool_puts - Write string to ethtool string data
+ * @data: Pointer to start of string to update
+ * @str: String to write
+ *
+ * Write string to data. Update data to point at start of next
+ * string.
+ *
+ * Prefer this function to ethtool_sprintf() when given only
+ * two arguments or if @fmt is just "%s".
+ */
+extern void ethtool_puts(u8 **data, const char *str);
+
 /* Link mode to forced speed capabilities maps */
 struct ethtool_forced_speed_map {
-	u32		speed;
+	u32 speed;
 	__ETHTOOL_DECLARE_LINK_MODE_MASK(caps);
 
-	const u32	*cap_arr;
-	u32		arr_size;
+	const u32 *cap_arr;
+	u32 arr_size;
 };
 
-#define ETHTOOL_FORCED_SPEED_MAP(prefix, value)				\
-{									\
-	.speed		= SPEED_##value,				\
-	.cap_arr	= prefix##_##value,				\
-	.arr_size	= ARRAY_SIZE(prefix##_##value),			\
-}
+#define ETHTOOL_FORCED_SPEED_MAP(prefix, value)                      \
+	{                                                            \
+		.speed = SPEED_##value, .cap_arr = prefix##_##value, \
+		.arr_size = ARRAY_SIZE(prefix##_##value),            \
+	}
 
-void
-ethtool_forced_speed_maps_init(struct ethtool_forced_speed_map *maps, u32 size);
+void ethtool_forced_speed_maps_init(struct ethtool_forced_speed_map *maps,
+				    u32 size);
 #endif /* _LINUX_ETHTOOL_H */
diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 0b0ce4f81c01..abdf05edf804 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -1991,6 +1991,13 @@ __printf(2, 3) void ethtool_sprintf(u8 **data, const char *fmt, ...)
 }
 EXPORT_SYMBOL(ethtool_sprintf);
 
+void ethtool_puts(u8 **data, const char *str)
+{
+	strscpy(*data, str, ETH_GSTRING_LEN);
+	*data += ETH_GSTRING_LEN;
+}
+EXPORT_SYMBOL(ethtool_puts);
+
 static int ethtool_phys_id(struct net_device *dev, void __user *useraddr)
 {
 	struct ethtool_value id;

-- 
2.42.0.820.g83a721a137-goog


