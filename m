Return-Path: <bpf+bounces-13363-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E867D8AF6
	for <lists+bpf@lfdr.de>; Thu, 26 Oct 2023 23:56:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47D0128216F
	for <lists+bpf@lfdr.de>; Thu, 26 Oct 2023 21:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6BDB3F4D5;
	Thu, 26 Oct 2023 21:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s3uedDKO"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D793E482
	for <bpf@vger.kernel.org>; Thu, 26 Oct 2023 21:56:19 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE861B8
	for <bpf@vger.kernel.org>; Thu, 26 Oct 2023 14:56:17 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d815354ea7fso1013638276.1
        for <bpf@vger.kernel.org>; Thu, 26 Oct 2023 14:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698357376; x=1698962176; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dYFCbbBAM6Yzga/rYjukRYsp/POsV5oivqv/XEKMawY=;
        b=s3uedDKO57Gbbjj5ckqs2yI/l/NMPrzoFUTVteFYNqT0wdbrNFOyCbCJuFEByoxTAA
         JQpgp42ryiIzTlXUHumVLjTW3WjN90jmHeBHezePUDDhRMm2fK4MZDnLHu25esuq/idr
         eyFwZhEC6sl7ZaIOcK0Rv0eAzryGQPveVBbB3/uO5m9fGNNItWJebKyErRLQYUTXIFyr
         9iQwGzpsdUfkwLm2UdN/pYlmE3LgUVCmWK+vVUIESVZHzub3JTFXIy65UBQ4xeonC2Cw
         bThaKeZSTSA+F9yZrBQSDUMoeACAken3LAGWVDOThmuvzJ+IvnrO9zGzLB/GSf5jyDoX
         mcAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698357376; x=1698962176;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dYFCbbBAM6Yzga/rYjukRYsp/POsV5oivqv/XEKMawY=;
        b=xGR8J9Y6Et3B9iQjFHDWk0XZ3QRMxnk4kwSsbJPezpbt2Ui9kREjhfg3rZ1Nm+gSLc
         iBvnCORCe8B6Jbnj9NAR+2QhrhnZWYrSZco8yUfhmDtv233LSJLcQm1eFnM0Ec6XXwox
         o5mnAQe8DqH7EIN8pgeMJFBOVPHoACQnb2W20SDSFC2/k/NBvsjXI5nQ+xEFB05njPBX
         Yes1RB2QcGYG7KgYUEMPs4jTKPYNZ+CX0yFSc/M7qS7zRmS8XwClG3ELAh33QwfNAKFs
         EPMNiZGCEie6F7CxwciuSYgEd7lenPyyfaybZcoHe0hXfBkwuCZQiHtSsrN4twpPf8+B
         Di5g==
X-Gm-Message-State: AOJu0YyzRdNNENz58FpbaMdGWyQ0AhtiSJ8c+bCaapIzVagTezInSP2u
	Joivoa4mjuAeLjURQ2wHYBbo0xyI4Qdm1HuXwQ==
X-Google-Smtp-Source: AGHT+IEfb7oOzPF36nMjYrY6yuwt7u5aPWQywSkNLJU2looIRNzyUO73wvXREAmdoYaSsyaeoRl83oRT8BPm+HpxYA==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a5b:9d2:0:b0:d9a:bce6:acf3 with SMTP
 id y18-20020a5b09d2000000b00d9abce6acf3mr18000ybq.0.1698357376212; Thu, 26
 Oct 2023 14:56:16 -0700 (PDT)
Date: Thu, 26 Oct 2023 21:56:08 +0000
In-Reply-To: <20231026-ethtool_puts_impl-v2-0-0d67cbdd0538@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231026-ethtool_puts_impl-v2-0-0d67cbdd0538@google.com>
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1698357372; l=1942;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=Tttx+U2qjudejsJUauC/KpxZsIK2OKqCPCc+Ch/fVls=; b=elpAQEsU3HOMMos/TnCJkrVo+AFG/1lerU81cOH+T2BgSHRjrFvGR7BmTA25L2uIiNK2WLsQZ
 m5JhXI8wJOxDHnWxVC+YAmf+U1BnkfHv0NAyeBvW/Fv+InbmfMY7Pw4
X-Mailer: b4 0.12.3
Message-ID: <20231026-ethtool_puts_impl-v2-2-0d67cbdd0538@google.com>
Subject: [PATCH next v2 2/3] checkpatch: add ethtool_sprintf rules
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

Add some warnings for using ethtool_sprintf() where a simple
ethtool_puts() would suffice.

The two cases are:

1) Use ethtool_sprintf() with just two arguments:
|       ethtool_sprintf(&data, driver[i].name);
or
2) Use ethtool_sprintf() with a standalone "%s" fmt string:
|       ethtool_sprintf(&data, "%s", driver[i].name);

The former may cause -Wformat-security warnings while the latter is just
not preferred. Both are safely in the category of warnings, not errors.

Signed-off-by: Justin Stitt <justinstitt@google.com>
---
 scripts/checkpatch.pl | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 25fdb7fda112..22f007131337 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -7011,6 +7011,25 @@ sub process {
 			     "Prefer strscpy, strscpy_pad, or __nonstring over strncpy - see: https://github.com/KSPP/linux/issues/90\n" . $herecurr);
 		}
 
+# ethtool_sprintf uses that should likely be ethtool_puts
+		if ($line =~ /\bethtool_sprintf\s*\(\s*$FuncArg\s*,\s*$FuncArg\s*\)/) {
+			if(WARN("ETHTOOL_SPRINTF",
+			   "Prefer ethtool_puts over ethtool_sprintf with only two arguments\n" . $herecurr) &&
+         $fix) {
+         $fixed[$fixlinenr] =~ s/ethtool_sprintf\s*\(/ethtool_puts\(/;
+       }
+		}
+
+		# use $rawline because $line loses %s via sanitization and thus we can't match against it.
+		if ($rawline =~ /\bethtool_sprintf\s*\(\s*$FuncArg\s*,\s*\"\%s\"\s*,\s*$FuncArg\s*\)/) {
+			if(WARN("ETHTOOL_SPRINTF",
+			   "Prefer ethtool_puts over ethtool_sprintf with standalone \"%s\" specifier\n" . $herecurr) &&
+         $fix) {
+         $fixed[$fixlinenr] =~ s/ethtool_sprintf\s*\(\s*(.*?),.*?,(.*?)\)/ethtool_puts\($1,$2)/;
+       }
+		}
+
+
 # typecasts on min/max could be min_t/max_t
 		if ($perl_version_ok &&
 		    defined $stat &&

-- 
2.42.0.820.g83a721a137-goog


