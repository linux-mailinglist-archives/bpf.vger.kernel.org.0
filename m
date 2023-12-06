Return-Path: <bpf+bounces-16950-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1AB8807C2B
	for <lists+bpf@lfdr.de>; Thu,  7 Dec 2023 00:16:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6409A282519
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 23:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6763130FA8;
	Wed,  6 Dec 2023 23:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wrXBQef4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDC9210C0
	for <bpf@vger.kernel.org>; Wed,  6 Dec 2023 15:16:17 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5caf86963ecso490897b3.3
        for <bpf@vger.kernel.org>; Wed, 06 Dec 2023 15:16:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701904577; x=1702509377; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=l2kWA06Tv172IMegEBtFHRUM7NNFaAXM0DXA+ADIdjk=;
        b=wrXBQef4BivDpMwf9efbJU1kFR1awxtQm3mA9kDCwKhYX9WAiQYilDsZAWtuFKfnFP
         jGROwyeRzHbfZjp2mVEVtjbxDLp3p0N8GKzVZWUaS4tYvgccf2BFoRXOGc6VFy1aNAgi
         6B6UyaFGwmr1jFDk2gMT6mquTqHM90bkCTOzX/VTqsWE3CX3TzUzrVIZiLmOrl/u4woW
         Q3ASzoAAGuyDzHDNhieLPA2TEQlayz6X90OxCBA8AGXZJoObWdMuai86o4bGs9XwCRVD
         ltBT1pusLErPoDJL6bn2lkMIDLp9YlYcvqYrQ4mNYqPEzKHt5Cq1NsyMlPRtSTQ32Edm
         luyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701904577; x=1702509377;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l2kWA06Tv172IMegEBtFHRUM7NNFaAXM0DXA+ADIdjk=;
        b=IyJykEPZSKDRXl9vSlys9vaS65Wm1fDRn6Ya2IAIOBgoZv7vvguaOcAOFTi6yyjOCp
         x7LKcFYx5TJZsqlJOUQZPJU1wao7D2OHHRnZzHncEf3FIWZ6xp5sLEia3N/qfSNyaqGo
         YVRflZeb5ShaER3pNhJDhTP1xpnjI9ZR+GTFuaD21Gr1axk9DQ1VvlrW+jYPpYg0ydXd
         XUB2+VG7Lk1kdERDZfisSEVv+9T3P3WvqVoqBdIj5mE+C+MHslimVAc5Whp26Qi5ueEe
         lqDArxf2MkG9N1bv6IdZWgu4C9AN+Bb9t9Qcjtc1aKq8D1I/WWJYK8SQWbSrgHUGJdpe
         nTmw==
X-Gm-Message-State: AOJu0YyYzxXHdx7OLqJWLmhfs3vcSgRv5ivu1jveVrWGqpQ1m2xZF6go
	xY6mEaA3DaklBd0FIBIqyBsuf9PrBcdowmm08A==
X-Google-Smtp-Source: AGHT+IEMd/xS2syY8YcxUE+jFNtUErStoqR6wMHC+Hu8IQ3Kowhzp4mcbmDmCUP7K5L1nughcxOsG1xLC/GwjEheoQ==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:d84e:0:b0:db3:5b0a:f274 with SMTP
 id p75-20020a25d84e000000b00db35b0af274mr25995ybg.0.1701904577009; Wed, 06
 Dec 2023 15:16:17 -0800 (PST)
Date: Wed, 06 Dec 2023 23:16:11 +0000
In-Reply-To: <20231206-ethtool_puts_impl-v5-0-5a2528e17bf8@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231206-ethtool_puts_impl-v5-0-5a2528e17bf8@google.com>
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701904573; l=1994;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=JqgyVZ/lMWBcIL4WYVyOFjI42i4J6KNM5TZC8fVlDHw=; b=5wv2E+fU7luADvsAMYtCjNbTJcSsyC0RjHSAuunlQsU1ZDIXqaBaMVwfXSYg3av2hcyZ4RP6s
 XfEcT5fza/xCUvpPtigE+b//xXA7T8IwbrdOIZp8LHuMTe8gG7Y6xG8
X-Mailer: b4 0.12.3
Message-ID: <20231206-ethtool_puts_impl-v5-2-5a2528e17bf8@google.com>
Subject: [PATCH net-next v5 2/3] checkpatch: add ethtool_sprintf rules
From: justinstitt@google.com
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
index 25fdb7fda112..6924731110d8 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -7011,6 +7011,25 @@ sub process {
 			     "Prefer strscpy, strscpy_pad, or __nonstring over strncpy - see: https://github.com/KSPP/linux/issues/90\n" . $herecurr);
 		}
 
+# ethtool_sprintf uses that should likely be ethtool_puts
+		if ($line =~ /\bethtool_sprintf\s*\(\s*$FuncArg\s*,\s*$FuncArg\s*\)/) {
+			if (WARN("PREFER_ETHTOOL_PUTS",
+				 "Prefer ethtool_puts over ethtool_sprintf with only two arguments\n" . $herecurr) &&
+			    $fix) {
+				$fixed[$fixlinenr] =~ s/\bethtool_sprintf\s*\(\s*($FuncArg)\s*,\s*($FuncArg)/ethtool_puts($1, $7)/;
+			}
+		}
+
+		# use $rawline because $line loses %s via sanitization and thus we can't match against it.
+		if ($rawline =~ /\bethtool_sprintf\s*\(\s*$FuncArg\s*,\s*\"\%s\"\s*,\s*$FuncArg\s*\)/) {
+			if (WARN("PREFER_ETHTOOL_PUTS",
+				 "Prefer ethtool_puts over ethtool_sprintf with standalone \"%s\" specifier\n" . $herecurr) &&
+			    $fix) {
+				$fixed[$fixlinenr] =~ s/\bethtool_sprintf\s*\(\s*($FuncArg)\s*,\s*"\%s"\s*,\s*($FuncArg)/ethtool_puts($1, $7)/;
+			}
+		}
+
+
 # typecasts on min/max could be min_t/max_t
 		if ($perl_version_ok &&
 		    defined $stat &&

-- 
2.43.0.rc2.451.g8631bc7472-goog


