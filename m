Return-Path: <bpf+bounces-23118-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1B2286DBF9
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 08:17:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68DE528AB3D
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 07:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C236994F;
	Fri,  1 Mar 2024 07:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F1rKb5Mj"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2036F69313;
	Fri,  1 Mar 2024 07:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709277426; cv=none; b=eJ/FxitLMkpC4lXNqUyqruhEICwDyQuYIuyLkZC4j2buqNRo1gH+WbZuys/WKcoe0AfNo2yGJJpqpvqvLwyoH+YwlrkIaNeHJhy8BjOZj67Ijm15+qZ3tRi53Ifelszm02ib9NpOeJ0aalnTXUcOrpAk4rdsJ/OmsQexT8hQO/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709277426; c=relaxed/simple;
	bh=mD7rmkR8pGFhQrhTJFYfZSZ0ykqU+bqCxiZeop4TUTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JEJAk8AJpHZGxPyCXTXx+IN4m+Z1zrTBeLi1MR5rkm32ZKwysxQNQMdODdw+BwR+n551hZafPGTN88bd5oTYafC3xzMkIUcMQ3nELtBDWwTr9DuoIWDx58g+LEqGfH/+GztzieuoBeKRy2RvPMWbThu3K7gMksu3DH5nlm9bEoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F1rKb5Mj; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709277422; x=1740813422;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=mD7rmkR8pGFhQrhTJFYfZSZ0ykqU+bqCxiZeop4TUTU=;
  b=F1rKb5MjCrRqH9EypLUjBAUHyls3ZtpgAPWL5//RxbPLnPsc8RGGyzR2
   +HyjDtokO6qCIC7V08LALiZDXwaUD6lZBYiyQMM158IlBbgd1fY1O8P7z
   ZuMitZBbe5/7tvO6gow/xWtNBgXi0eEEopzu29Q7MWdro81ZQAuA/H20u
   O4VjQyWEhfx4UzKI2TmQmx/XeGcbH3ItdUquCRQWtT0IoV2ZAq1LVxxiS
   tAjRPUdHTBnfwgivljzFKV5v8V9RNMTDGHCCjMjyCHKSa7Z7CGMEJzwuf
   9lxFx07ha2/YHiWYdZFwpZgxzlTGdXhgLbZbcSdcfDQ9SRgLDUUj4+rf9
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="15211006"
X-IronPort-AV: E=Sophos;i="6.06,195,1705392000"; 
   d="scan'208";a="15211006"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 23:17:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,195,1705392000"; 
   d="scan'208";a="39127582"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 29 Feb 2024 23:16:56 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rfx8X-000DcR-23;
	Fri, 01 Mar 2024 07:16:53 +0000
Date: Fri, 1 Mar 2024 15:16:29 +0800
From: kernel test robot <lkp@intel.com>
To: Frank Li <Frank.Li@nxp.com>, Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-pci@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH 2/6] PCI: imx6: Rename pci-imx6.c and PCI_IMX6 config
Message-ID: <202403011431.vIVOdwob-lkp@intel.com>
References: <20240227-pci2_upstream-v1-2-b952f8333606@nxp.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240227-pci2_upstream-v1-2-b952f8333606@nxp.com>

Hi Frank,

kernel test robot noticed the following build warnings:

[auto build test WARNING on b73259dcd67094e883104a0390852695caf3f999]

url:    https://github.com/intel-lab-lkp/linux/commits/Frank-Li/PCI-imx6-Rename-imx6_-with-imx_/20240228-055254
base:   b73259dcd67094e883104a0390852695caf3f999
patch link:    https://lore.kernel.org/r/20240227-pci2_upstream-v1-2-b952f8333606%40nxp.com
patch subject: [PATCH 2/6] PCI: imx6: Rename pci-imx6.c and PCI_IMX6 config
config: x86_64-allmodconfig (https://download.01.org/0day-ci/archive/20240301/202403011431.vIVOdwob-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240301/202403011431.vIVOdwob-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403011431.vIVOdwob-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/pci/controller/dwc/pci-imx.c:1333:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
    1333 |         default:
         |         ^
   drivers/pci/controller/dwc/pci-imx.c:1333:2: note: insert 'break;' to avoid fall-through
    1333 |         default:
         |         ^
         |         break; 
   1 warning generated.


vim +1333 drivers/pci/controller/dwc/pci-imx.c

0ee2c1f2429f74 drivers/pci/controller/dwc/pci-imx6.c Leonard Crestez        2018-08-27  1230  
f988153d367a9c drivers/pci/controller/dwc/pci-imx6.c Frank Li               2024-02-27  1231  static int imx_pcie_probe(struct platform_device *pdev)
bb38919ec56e07 drivers/pci/host/pci-imx6.c           Sean Cross             2013-09-26  1232  {
13957652f7242a drivers/pci/host/pci-imx6.c           Bjorn Helgaas          2016-10-06  1233  	struct device *dev = &pdev->dev;
442ec4c04d1235 drivers/pci/dwc/pci-imx6.c            Kishon Vijay Abraham I 2017-02-15  1234  	struct dw_pcie *pci;
f988153d367a9c drivers/pci/controller/dwc/pci-imx6.c Frank Li               2024-02-27  1235  	struct imx_pcie *imx_pcie;
1df82ec4660099 drivers/pci/controller/dwc/pci-imx6.c Trent Piepho           2019-02-05  1236  	struct device_node *np;
bb38919ec56e07 drivers/pci/host/pci-imx6.c           Sean Cross             2013-09-26  1237  	struct resource *dbi_base;
13957652f7242a drivers/pci/host/pci-imx6.c           Bjorn Helgaas          2016-10-06  1238  	struct device_node *node = dev->of_node;
bb38919ec56e07 drivers/pci/host/pci-imx6.c           Sean Cross             2013-09-26  1239  	int ret;
75cb8d20c112ab drivers/pci/controller/dwc/pci-imx6.c Richard Zhu            2018-12-21  1240  	u16 val;
6a40185838759c drivers/pci/controller/dwc/pci-imx6.c Frank Li               2024-02-20  1241  	int i;
bb38919ec56e07 drivers/pci/host/pci-imx6.c           Sean Cross             2013-09-26  1242  
f988153d367a9c drivers/pci/controller/dwc/pci-imx6.c Frank Li               2024-02-27  1243  	imx_pcie = devm_kzalloc(dev, sizeof(*imx_pcie), GFP_KERNEL);
f988153d367a9c drivers/pci/controller/dwc/pci-imx6.c Frank Li               2024-02-27  1244  	if (!imx_pcie)
bb38919ec56e07 drivers/pci/host/pci-imx6.c           Sean Cross             2013-09-26  1245  		return -ENOMEM;
bb38919ec56e07 drivers/pci/host/pci-imx6.c           Sean Cross             2013-09-26  1246  
442ec4c04d1235 drivers/pci/dwc/pci-imx6.c            Kishon Vijay Abraham I 2017-02-15  1247  	pci = devm_kzalloc(dev, sizeof(*pci), GFP_KERNEL);
442ec4c04d1235 drivers/pci/dwc/pci-imx6.c            Kishon Vijay Abraham I 2017-02-15  1248  	if (!pci)
442ec4c04d1235 drivers/pci/dwc/pci-imx6.c            Kishon Vijay Abraham I 2017-02-15  1249  		return -ENOMEM;
442ec4c04d1235 drivers/pci/dwc/pci-imx6.c            Kishon Vijay Abraham I 2017-02-15  1250  
442ec4c04d1235 drivers/pci/dwc/pci-imx6.c            Kishon Vijay Abraham I 2017-02-15  1251  	pci->dev = dev;
442ec4c04d1235 drivers/pci/dwc/pci-imx6.c            Kishon Vijay Abraham I 2017-02-15  1252  	pci->ops = &dw_pcie_ops;
f988153d367a9c drivers/pci/controller/dwc/pci-imx6.c Frank Li               2024-02-27  1253  	pci->pp.ops = &imx_pcie_host_ops;
bb38919ec56e07 drivers/pci/host/pci-imx6.c           Sean Cross             2013-09-26  1254  
f988153d367a9c drivers/pci/controller/dwc/pci-imx6.c Frank Li               2024-02-27  1255  	imx_pcie->pci = pci;
f988153d367a9c drivers/pci/controller/dwc/pci-imx6.c Frank Li               2024-02-27  1256  	imx_pcie->drvdata = of_device_get_match_data(dev);
e3c06cd063d69d drivers/pci/host/pci-imx6.c           Christoph Fritz        2016-04-05  1257  
1df82ec4660099 drivers/pci/controller/dwc/pci-imx6.c Trent Piepho           2019-02-05  1258  	/* Find the PHY if one is defined, only imx7d uses it */
1df82ec4660099 drivers/pci/controller/dwc/pci-imx6.c Trent Piepho           2019-02-05  1259  	np = of_parse_phandle(node, "fsl,imx7d-pcie-phy", 0);
1df82ec4660099 drivers/pci/controller/dwc/pci-imx6.c Trent Piepho           2019-02-05  1260  	if (np) {
1df82ec4660099 drivers/pci/controller/dwc/pci-imx6.c Trent Piepho           2019-02-05  1261  		struct resource res;
1df82ec4660099 drivers/pci/controller/dwc/pci-imx6.c Trent Piepho           2019-02-05  1262  
1df82ec4660099 drivers/pci/controller/dwc/pci-imx6.c Trent Piepho           2019-02-05  1263  		ret = of_address_to_resource(np, 0, &res);
1df82ec4660099 drivers/pci/controller/dwc/pci-imx6.c Trent Piepho           2019-02-05  1264  		if (ret) {
1df82ec4660099 drivers/pci/controller/dwc/pci-imx6.c Trent Piepho           2019-02-05  1265  			dev_err(dev, "Unable to map PCIe PHY\n");
1df82ec4660099 drivers/pci/controller/dwc/pci-imx6.c Trent Piepho           2019-02-05  1266  			return ret;
1df82ec4660099 drivers/pci/controller/dwc/pci-imx6.c Trent Piepho           2019-02-05  1267  		}
f988153d367a9c drivers/pci/controller/dwc/pci-imx6.c Frank Li               2024-02-27  1268  		imx_pcie->phy_base = devm_ioremap_resource(dev, &res);
f988153d367a9c drivers/pci/controller/dwc/pci-imx6.c Frank Li               2024-02-27  1269  		if (IS_ERR(imx_pcie->phy_base))
f988153d367a9c drivers/pci/controller/dwc/pci-imx6.c Frank Li               2024-02-27  1270  			return PTR_ERR(imx_pcie->phy_base);
1df82ec4660099 drivers/pci/controller/dwc/pci-imx6.c Trent Piepho           2019-02-05  1271  	}
e3c06cd063d69d drivers/pci/host/pci-imx6.c           Christoph Fritz        2016-04-05  1272  
188f46cac267b9 drivers/pci/controller/dwc/pci-imx6.c Yang Li                2023-03-23  1273  	pci->dbi_base = devm_platform_get_and_ioremap_resource(pdev, 0, &dbi_base);
442ec4c04d1235 drivers/pci/dwc/pci-imx6.c            Kishon Vijay Abraham I 2017-02-15  1274  	if (IS_ERR(pci->dbi_base))
442ec4c04d1235 drivers/pci/dwc/pci-imx6.c            Kishon Vijay Abraham I 2017-02-15  1275  		return PTR_ERR(pci->dbi_base);
bb38919ec56e07 drivers/pci/host/pci-imx6.c           Sean Cross             2013-09-26  1276  
bb38919ec56e07 drivers/pci/host/pci-imx6.c           Sean Cross             2013-09-26  1277  	/* Fetch GPIOs */
f988153d367a9c drivers/pci/controller/dwc/pci-imx6.c Frank Li               2024-02-27  1278  	imx_pcie->reset_gpio = of_get_named_gpio(node, "reset-gpio", 0);
f988153d367a9c drivers/pci/controller/dwc/pci-imx6.c Frank Li               2024-02-27  1279  	imx_pcie->gpio_active_high = of_property_read_bool(node,
3ea8529acc3046 drivers/pci/host/pci-imx6.c           Petr Štetiar           2016-04-19  1280  						"reset-gpio-active-high");
f988153d367a9c drivers/pci/controller/dwc/pci-imx6.c Frank Li               2024-02-27  1281  	if (gpio_is_valid(imx_pcie->reset_gpio)) {
f988153d367a9c drivers/pci/controller/dwc/pci-imx6.c Frank Li               2024-02-27  1282  		ret = devm_gpio_request_one(dev, imx_pcie->reset_gpio,
f988153d367a9c drivers/pci/controller/dwc/pci-imx6.c Frank Li               2024-02-27  1283  				imx_pcie->gpio_active_high ?
3ea8529acc3046 drivers/pci/host/pci-imx6.c           Petr Štetiar           2016-04-19  1284  					GPIOF_OUT_INIT_HIGH :
3ea8529acc3046 drivers/pci/host/pci-imx6.c           Petr Štetiar           2016-04-19  1285  					GPIOF_OUT_INIT_LOW,
3ea8529acc3046 drivers/pci/host/pci-imx6.c           Petr Štetiar           2016-04-19  1286  				"PCIe reset");
b2d7a9cd3ff8ec drivers/pci/host/pci-imx6.c           Fabio Estevam          2016-03-28  1287  		if (ret) {
13957652f7242a drivers/pci/host/pci-imx6.c           Bjorn Helgaas          2016-10-06  1288  			dev_err(dev, "unable to get reset gpio\n");
b2d7a9cd3ff8ec drivers/pci/host/pci-imx6.c           Fabio Estevam          2016-03-28  1289  			return ret;
b2d7a9cd3ff8ec drivers/pci/host/pci-imx6.c           Fabio Estevam          2016-03-28  1290  		}
f988153d367a9c drivers/pci/controller/dwc/pci-imx6.c Frank Li               2024-02-27  1291  	} else if (imx_pcie->reset_gpio == -EPROBE_DEFER) {
f988153d367a9c drivers/pci/controller/dwc/pci-imx6.c Frank Li               2024-02-27  1292  		return imx_pcie->reset_gpio;
b2d7a9cd3ff8ec drivers/pci/host/pci-imx6.c           Fabio Estevam          2016-03-28  1293  	}
bb38919ec56e07 drivers/pci/host/pci-imx6.c           Sean Cross             2013-09-26  1294  
f988153d367a9c drivers/pci/controller/dwc/pci-imx6.c Frank Li               2024-02-27  1295  	if (imx_pcie->drvdata->clks_cnt >= IMX_PCIE_MAX_CLKS)
6a40185838759c drivers/pci/controller/dwc/pci-imx6.c Frank Li               2024-02-20  1296  		return dev_err_probe(dev, -ENOMEM, "clks_cnt is too big\n");
bb38919ec56e07 drivers/pci/host/pci-imx6.c           Sean Cross             2013-09-26  1297  
f988153d367a9c drivers/pci/controller/dwc/pci-imx6.c Frank Li               2024-02-27  1298  	for (i = 0; i < imx_pcie->drvdata->clks_cnt; i++)
f988153d367a9c drivers/pci/controller/dwc/pci-imx6.c Frank Li               2024-02-27  1299  		imx_pcie->clks[i].id = imx_pcie->drvdata->clk_names[i];
6a40185838759c drivers/pci/controller/dwc/pci-imx6.c Frank Li               2024-02-20  1300  
6a40185838759c drivers/pci/controller/dwc/pci-imx6.c Frank Li               2024-02-20  1301  	/* Fetch clocks */
f988153d367a9c drivers/pci/controller/dwc/pci-imx6.c Frank Li               2024-02-27  1302  	ret = devm_clk_bulk_get(dev, imx_pcie->drvdata->clks_cnt, imx_pcie->clks);
6a40185838759c drivers/pci/controller/dwc/pci-imx6.c Frank Li               2024-02-20  1303  	if (ret)
6a40185838759c drivers/pci/controller/dwc/pci-imx6.c Frank Li               2024-02-20  1304  		return ret;
bb38919ec56e07 drivers/pci/host/pci-imx6.c           Sean Cross             2013-09-26  1305  
f988153d367a9c drivers/pci/controller/dwc/pci-imx6.c Frank Li               2024-02-27  1306  	if (imx_check_flag(imx_pcie, IMX_PCIE_FLAG_HAS_PHYDRV)) {
f988153d367a9c drivers/pci/controller/dwc/pci-imx6.c Frank Li               2024-02-27  1307  		imx_pcie->phy = devm_phy_get(dev, "pcie-phy");
f988153d367a9c drivers/pci/controller/dwc/pci-imx6.c Frank Li               2024-02-27  1308  		if (IS_ERR(imx_pcie->phy))
f988153d367a9c drivers/pci/controller/dwc/pci-imx6.c Frank Li               2024-02-27  1309  			return dev_err_probe(dev, PTR_ERR(imx_pcie->phy),
4e37c2f48712d5 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2024-02-20  1310  					     "failed to get pcie phy\n");
4e37c2f48712d5 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2024-02-20  1311  	}
4e37c2f48712d5 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2024-02-20  1312  
f988153d367a9c drivers/pci/controller/dwc/pci-imx6.c Frank Li               2024-02-27  1313  	if (imx_check_flag(imx_pcie, IMX_PCIE_FLAG_HAS_APP_RESET)) {
f988153d367a9c drivers/pci/controller/dwc/pci-imx6.c Frank Li               2024-02-27  1314  		imx_pcie->apps_reset = devm_reset_control_get_exclusive(dev, "apps");
f988153d367a9c drivers/pci/controller/dwc/pci-imx6.c Frank Li               2024-02-27  1315  		if (IS_ERR(imx_pcie->apps_reset))
f988153d367a9c drivers/pci/controller/dwc/pci-imx6.c Frank Li               2024-02-27  1316  			return dev_err_probe(dev, PTR_ERR(imx_pcie->apps_reset),
666a7beb942cc6 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2024-02-20  1317  					     "failed to get pcie apps reset control\n");
666a7beb942cc6 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2024-02-20  1318  	}
666a7beb942cc6 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2024-02-20  1319  
f988153d367a9c drivers/pci/controller/dwc/pci-imx6.c Frank Li               2024-02-27  1320  	if (imx_check_flag(imx_pcie, IMX_PCIE_FLAG_HAS_PHY_RESET)) {
f988153d367a9c drivers/pci/controller/dwc/pci-imx6.c Frank Li               2024-02-27  1321  		imx_pcie->pciephy_reset = devm_reset_control_get_exclusive(dev, "pciephy");
f988153d367a9c drivers/pci/controller/dwc/pci-imx6.c Frank Li               2024-02-27  1322  		if (IS_ERR(imx_pcie->pciephy_reset))
f988153d367a9c drivers/pci/controller/dwc/pci-imx6.c Frank Li               2024-02-27  1323  			return dev_err_probe(dev, PTR_ERR(imx_pcie->pciephy_reset),
666a7beb942cc6 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2024-02-20  1324  					     "Failed to get PCIEPHY reset control\n");
666a7beb942cc6 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2024-02-20  1325  	}
666a7beb942cc6 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2024-02-20  1326  
f988153d367a9c drivers/pci/controller/dwc/pci-imx6.c Frank Li               2024-02-27  1327  	switch (imx_pcie->drvdata->variant) {
2d8ed461dbc9bc drivers/pci/controller/dwc/pci-imx6.c Andrey Smirnov         2019-02-01  1328  	case IMX8MQ:
530ba41250b69d drivers/pci/controller/dwc/pci-imx6.c Richard Zhu            2023-01-16  1329  	case IMX8MQ_EP:
9b3fe6796d7c0e drivers/pci/dwc/pci-imx6.c            Andrey Smirnov         2017-03-28  1330  	case IMX7D:
2d8ed461dbc9bc drivers/pci/controller/dwc/pci-imx6.c Andrey Smirnov         2019-02-01  1331  		if (dbi_base->start == IMX8MQ_PCIE2_BASE_ADDR)
f988153d367a9c drivers/pci/controller/dwc/pci-imx6.c Frank Li               2024-02-27  1332  			imx_pcie->controller_id = 1;
9b3fe6796d7c0e drivers/pci/dwc/pci-imx6.c            Andrey Smirnov         2017-03-28 @1333  	default:
9b3fe6796d7c0e drivers/pci/dwc/pci-imx6.c            Andrey Smirnov         2017-03-28  1334  		break;
e3c06cd063d69d drivers/pci/host/pci-imx6.c           Christoph Fritz        2016-04-05  1335  	}
e3c06cd063d69d drivers/pci/host/pci-imx6.c           Christoph Fritz        2016-04-05  1336  
f4e833ba2a955b drivers/pci/controller/dwc/pci-imx6.c Leonard Crestez        2018-07-19  1337  	/* Grab turnoff reset */
f988153d367a9c drivers/pci/controller/dwc/pci-imx6.c Frank Li               2024-02-27  1338  	imx_pcie->turnoff_reset = devm_reset_control_get_optional_exclusive(dev, "turnoff");
f988153d367a9c drivers/pci/controller/dwc/pci-imx6.c Frank Li               2024-02-27  1339  	if (IS_ERR(imx_pcie->turnoff_reset)) {
f4e833ba2a955b drivers/pci/controller/dwc/pci-imx6.c Leonard Crestez        2018-07-19  1340  		dev_err(dev, "Failed to get TURNOFF reset control\n");
f988153d367a9c drivers/pci/controller/dwc/pci-imx6.c Frank Li               2024-02-27  1341  		return PTR_ERR(imx_pcie->turnoff_reset);
f4e833ba2a955b drivers/pci/controller/dwc/pci-imx6.c Leonard Crestez        2018-07-19  1342  	}
f4e833ba2a955b drivers/pci/controller/dwc/pci-imx6.c Leonard Crestez        2018-07-19  1343  
f988153d367a9c drivers/pci/controller/dwc/pci-imx6.c Frank Li               2024-02-27  1344  	if (imx_pcie->drvdata->gpr) {
bb38919ec56e07 drivers/pci/host/pci-imx6.c           Sean Cross             2013-09-26  1345  	/* Grab GPR config register range */
f988153d367a9c drivers/pci/controller/dwc/pci-imx6.c Frank Li               2024-02-27  1346  		imx_pcie->iomuxc_gpr =
f988153d367a9c drivers/pci/controller/dwc/pci-imx6.c Frank Li               2024-02-27  1347  			 syscon_regmap_lookup_by_compatible(imx_pcie->drvdata->gpr);
f988153d367a9c drivers/pci/controller/dwc/pci-imx6.c Frank Li               2024-02-27  1348  		if (IS_ERR(imx_pcie->iomuxc_gpr))
f988153d367a9c drivers/pci/controller/dwc/pci-imx6.c Frank Li               2024-02-27  1349  			return dev_err_probe(dev, PTR_ERR(imx_pcie->iomuxc_gpr),
98e97fb574b112 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2024-02-20  1350  					     "unable to find iomuxc registers\n");
98e97fb574b112 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2024-02-20  1351  	}
98e97fb574b112 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2024-02-20  1352  
f988153d367a9c drivers/pci/controller/dwc/pci-imx6.c Frank Li               2024-02-27  1353  	if (imx_check_flag(imx_pcie, IMX_PCIE_FLAG_HAS_SERDES)) {
98e97fb574b112 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2024-02-20  1354  		void __iomem *off = devm_platform_ioremap_resource_byname(pdev, "app");
98e97fb574b112 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2024-02-20  1355  
98e97fb574b112 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2024-02-20  1356  		if (IS_ERR(off))
98e97fb574b112 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2024-02-20  1357  			return dev_err_probe(dev, PTR_ERR(off),
98e97fb574b112 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2024-02-20  1358  					     "unable to find serdes registers\n");
98e97fb574b112 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2024-02-20  1359  
98e97fb574b112 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2024-02-20  1360  		static const struct regmap_config regmap_config = {
98e97fb574b112 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2024-02-20  1361  			.reg_bits = 32,
98e97fb574b112 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2024-02-20  1362  			.val_bits = 32,
98e97fb574b112 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2024-02-20  1363  			.reg_stride = 4,
98e97fb574b112 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2024-02-20  1364  		};
98e97fb574b112 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2024-02-20  1365  
f988153d367a9c drivers/pci/controller/dwc/pci-imx6.c Frank Li               2024-02-27  1366  		imx_pcie->iomuxc_gpr = devm_regmap_init_mmio(dev, off, &regmap_config);
f988153d367a9c drivers/pci/controller/dwc/pci-imx6.c Frank Li               2024-02-27  1367  		if (IS_ERR(imx_pcie->iomuxc_gpr))
f988153d367a9c drivers/pci/controller/dwc/pci-imx6.c Frank Li               2024-02-27  1368  			return dev_err_probe(dev, PTR_ERR(imx_pcie->iomuxc_gpr),
98e97fb574b112 drivers/pci/controller/dwc/pci-imx6.c Frank Li               2024-02-20  1369  					     "unable to find iomuxc registers\n");
bb38919ec56e07 drivers/pci/host/pci-imx6.c           Sean Cross             2013-09-26  1370  	}
28e3abe591e227 drivers/pci/host/pci-imx6.c           Justin Waters          2016-01-15  1371  
28e3abe591e227 drivers/pci/host/pci-imx6.c           Justin Waters          2016-01-15  1372  	/* Grab PCIe PHY Tx Settings */
28e3abe591e227 drivers/pci/host/pci-imx6.c           Justin Waters          2016-01-15  1373  	if (of_property_read_u32(node, "fsl,tx-deemph-gen1",
f988153d367a9c drivers/pci/controller/dwc/pci-imx6.c Frank Li               2024-02-27  1374  				 &imx_pcie->tx_deemph_gen1))
f988153d367a9c drivers/pci/controller/dwc/pci-imx6.c Frank Li               2024-02-27  1375  		imx_pcie->tx_deemph_gen1 = 0;
28e3abe591e227 drivers/pci/host/pci-imx6.c           Justin Waters          2016-01-15  1376  
28e3abe591e227 drivers/pci/host/pci-imx6.c           Justin Waters          2016-01-15  1377  	if (of_property_read_u32(node, "fsl,tx-deemph-gen2-3p5db",
f988153d367a9c drivers/pci/controller/dwc/pci-imx6.c Frank Li               2024-02-27  1378  				 &imx_pcie->tx_deemph_gen2_3p5db))
f988153d367a9c drivers/pci/controller/dwc/pci-imx6.c Frank Li               2024-02-27  1379  		imx_pcie->tx_deemph_gen2_3p5db = 0;
28e3abe591e227 drivers/pci/host/pci-imx6.c           Justin Waters          2016-01-15  1380  
28e3abe591e227 drivers/pci/host/pci-imx6.c           Justin Waters          2016-01-15  1381  	if (of_property_read_u32(node, "fsl,tx-deemph-gen2-6db",
f988153d367a9c drivers/pci/controller/dwc/pci-imx6.c Frank Li               2024-02-27  1382  				 &imx_pcie->tx_deemph_gen2_6db))
f988153d367a9c drivers/pci/controller/dwc/pci-imx6.c Frank Li               2024-02-27  1383  		imx_pcie->tx_deemph_gen2_6db = 20;
28e3abe591e227 drivers/pci/host/pci-imx6.c           Justin Waters          2016-01-15  1384  
28e3abe591e227 drivers/pci/host/pci-imx6.c           Justin Waters          2016-01-15  1385  	if (of_property_read_u32(node, "fsl,tx-swing-full",
f988153d367a9c drivers/pci/controller/dwc/pci-imx6.c Frank Li               2024-02-27  1386  				 &imx_pcie->tx_swing_full))
f988153d367a9c drivers/pci/controller/dwc/pci-imx6.c Frank Li               2024-02-27  1387  		imx_pcie->tx_swing_full = 127;
28e3abe591e227 drivers/pci/host/pci-imx6.c           Justin Waters          2016-01-15  1388  
28e3abe591e227 drivers/pci/host/pci-imx6.c           Justin Waters          2016-01-15  1389  	if (of_property_read_u32(node, "fsl,tx-swing-low",
f988153d367a9c drivers/pci/controller/dwc/pci-imx6.c Frank Li               2024-02-27  1390  				 &imx_pcie->tx_swing_low))
f988153d367a9c drivers/pci/controller/dwc/pci-imx6.c Frank Li               2024-02-27  1391  		imx_pcie->tx_swing_low = 127;
bb38919ec56e07 drivers/pci/host/pci-imx6.c           Sean Cross             2013-09-26  1392  
a5fcec480f25eb drivers/pci/host/pci-imx6.c           Tim Harvey             2016-04-19  1393  	/* Limit link speed */
39bc5006501cc3 drivers/pci/controller/dwc/pci-imx6.c Rob Herring            2020-08-20  1394  	pci->link_gen = 1;
65315ec52c9bd5 drivers/pci/controller/dwc/pci-imx6.c Krzysztof Wilczyński   2021-10-03  1395  	of_property_read_u32(node, "fsl,max-link-speed", &pci->link_gen);
a5fcec480f25eb drivers/pci/host/pci-imx6.c           Tim Harvey             2016-04-19  1396  
f988153d367a9c drivers/pci/controller/dwc/pci-imx6.c Frank Li               2024-02-27  1397  	imx_pcie->vpcie = devm_regulator_get_optional(&pdev->dev, "vpcie");
f988153d367a9c drivers/pci/controller/dwc/pci-imx6.c Frank Li               2024-02-27  1398  	if (IS_ERR(imx_pcie->vpcie)) {
f988153d367a9c drivers/pci/controller/dwc/pci-imx6.c Frank Li               2024-02-27  1399  		if (PTR_ERR(imx_pcie->vpcie) != -ENODEV)
f988153d367a9c drivers/pci/controller/dwc/pci-imx6.c Frank Li               2024-02-27  1400  			return PTR_ERR(imx_pcie->vpcie);
f988153d367a9c drivers/pci/controller/dwc/pci-imx6.c Frank Li               2024-02-27  1401  		imx_pcie->vpcie = NULL;
c26ebe98a10347 drivers/pci/dwc/pci-imx6.c            Quentin Schulz         2017-06-08  1402  	}
c26ebe98a10347 drivers/pci/dwc/pci-imx6.c            Quentin Schulz         2017-06-08  1403  
f988153d367a9c drivers/pci/controller/dwc/pci-imx6.c Frank Li               2024-02-27  1404  	imx_pcie->vph = devm_regulator_get_optional(&pdev->dev, "vph");
f988153d367a9c drivers/pci/controller/dwc/pci-imx6.c Frank Li               2024-02-27  1405  	if (IS_ERR(imx_pcie->vph)) {
f988153d367a9c drivers/pci/controller/dwc/pci-imx6.c Frank Li               2024-02-27  1406  		if (PTR_ERR(imx_pcie->vph) != -ENODEV)
f988153d367a9c drivers/pci/controller/dwc/pci-imx6.c Frank Li               2024-02-27  1407  			return PTR_ERR(imx_pcie->vph);
f988153d367a9c drivers/pci/controller/dwc/pci-imx6.c Frank Li               2024-02-27  1408  		imx_pcie->vph = NULL;
d2ce69ca251690 drivers/pci/controller/dwc/pci-imx6.c Richard Zhu            2021-06-04  1409  	}
d2ce69ca251690 drivers/pci/controller/dwc/pci-imx6.c Richard Zhu            2021-06-04  1410  
f988153d367a9c drivers/pci/controller/dwc/pci-imx6.c Frank Li               2024-02-27  1411  	platform_set_drvdata(pdev, imx_pcie);
9bcf0a6fdc5062 drivers/pci/dwc/pci-imx6.c            Kishon Vijay Abraham I 2017-02-15  1412  
f988153d367a9c drivers/pci/controller/dwc/pci-imx6.c Frank Li               2024-02-27  1413  	ret = imx_pcie_attach_pd(dev);
3f7cceeab895fc drivers/pci/controller/dwc/pci-imx6.c Leonard Crestez        2018-10-08  1414  	if (ret)
3f7cceeab895fc drivers/pci/controller/dwc/pci-imx6.c Leonard Crestez        2018-10-08  1415  		return ret;
3f7cceeab895fc drivers/pci/controller/dwc/pci-imx6.c Leonard Crestez        2018-10-08  1416  
f988153d367a9c drivers/pci/controller/dwc/pci-imx6.c Frank Li               2024-02-27  1417  	if (imx_pcie->drvdata->mode == DW_PCIE_EP_TYPE) {
f988153d367a9c drivers/pci/controller/dwc/pci-imx6.c Frank Li               2024-02-27  1418  		ret = imx_add_pcie_ep(imx_pcie, pdev);
75c2f26da03f93 drivers/pci/controller/dwc/pci-imx6.c Richard Zhu            2023-01-16  1419  		if (ret < 0)
75c2f26da03f93 drivers/pci/controller/dwc/pci-imx6.c Richard Zhu            2023-01-16  1420  			return ret;
75c2f26da03f93 drivers/pci/controller/dwc/pci-imx6.c Richard Zhu            2023-01-16  1421  	} else {
60f5b73fa0f298 drivers/pci/controller/dwc/pci-imx6.c Rob Herring            2020-11-05  1422  		ret = dw_pcie_host_init(&pci->pp);
bb38919ec56e07 drivers/pci/host/pci-imx6.c           Sean Cross             2013-09-26  1423  		if (ret < 0)
b391bf31584d87 drivers/pci/host/pci-imx6.c           Fabio Estevam          2013-12-02  1424  			return ret;
bb38919ec56e07 drivers/pci/host/pci-imx6.c           Sean Cross             2013-09-26  1425  
75cb8d20c112ab drivers/pci/controller/dwc/pci-imx6.c Richard Zhu            2018-12-21  1426  		if (pci_msi_enabled()) {
201a8df899525b drivers/pci/controller/dwc/pci-imx6.c Rob Herring            2020-08-20  1427  			u8 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_MSI);
75c2f26da03f93 drivers/pci/controller/dwc/pci-imx6.c Richard Zhu            2023-01-16  1428  
201a8df899525b drivers/pci/controller/dwc/pci-imx6.c Rob Herring            2020-08-20  1429  			val = dw_pcie_readw_dbi(pci, offset + PCI_MSI_FLAGS);
75cb8d20c112ab drivers/pci/controller/dwc/pci-imx6.c Richard Zhu            2018-12-21  1430  			val |= PCI_MSI_FLAGS_ENABLE;
201a8df899525b drivers/pci/controller/dwc/pci-imx6.c Rob Herring            2020-08-20  1431  			dw_pcie_writew_dbi(pci, offset + PCI_MSI_FLAGS, val);
75cb8d20c112ab drivers/pci/controller/dwc/pci-imx6.c Richard Zhu            2018-12-21  1432  		}
75c2f26da03f93 drivers/pci/controller/dwc/pci-imx6.c Richard Zhu            2023-01-16  1433  	}
75cb8d20c112ab drivers/pci/controller/dwc/pci-imx6.c Richard Zhu            2018-12-21  1434  
bb38919ec56e07 drivers/pci/host/pci-imx6.c           Sean Cross             2013-09-26  1435  	return 0;
bb38919ec56e07 drivers/pci/host/pci-imx6.c           Sean Cross             2013-09-26  1436  }
bb38919ec56e07 drivers/pci/host/pci-imx6.c           Sean Cross             2013-09-26  1437  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

