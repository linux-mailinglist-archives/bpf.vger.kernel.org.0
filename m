Return-Path: <bpf+bounces-3233-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0626073B020
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 07:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 382E31C21000
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 05:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5382B10F5;
	Fri, 23 Jun 2023 05:36:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED38A642;
	Fri, 23 Jun 2023 05:36:08 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2100.outbound.protection.outlook.com [40.107.237.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 936271A4;
	Thu, 22 Jun 2023 22:36:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e7r+h988TkrLeIagYgR5bJCSAOaUPCS7Ew4NsOS8hUh3OH5BiDvwU8JF6m0La0WmerBoA+lEFCGP5zhLzFHRQ62+REk+k0S0puyvhQ4FX1P7uTx4IK4YlDMavzrtxmmPJ+HoD82u2BFBJgyCxTrWdYn+3cRYoy+wl6bR4yDuVGu/LZQH1k2o2pegrb3IsO5Qm4fZvsqwEPrLGe9pdwdh/RV9MfG7lUGU+mZMw3AgcZYAVc7KmjSkUjjHTEnjVGcGdKuWyVOxfuAnBVT/63yccx3GdGSz9MLQ4SXsjoqlasQWBLvZnPaKPO0hVnMJnYMb49uOxYGTPtYEZTP/2BtMGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SGZSgp8e/Grrx6f1aSYwPhf6PzEMntVO8jAK8Tq7EdY=;
 b=jp2b36jXm40og1cK7m2tVo0G0HiFaZTKwq5XkgNetHhkoiIU3o0mqza92/nrsW7sJyRsVLZ/iNO9qnK5CLm2rw4rffCpqfGXZzR1gkoIElTpbl+c0X58NmqM0dlVre8BGpw9B6RwrS+KYy8vYI/ml0GxuPLbB9no59BuDZCpiK+OUkrX5B/91DLcIhqA7o/RxE6LRMESDGedIdeOuzruAhKevGr+AM7cRljXQqFmmn6CeuuDxkve8/Yyll38N6NrSW3GJH/PSJ1GzKu7fOs+yAJ77iBYu6CSZ8ZjZYzyhGYmFf9eWzkoOjslnSgoxyijjc0/ZJMePteX+lL1qSCACQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SGZSgp8e/Grrx6f1aSYwPhf6PzEMntVO8jAK8Tq7EdY=;
 b=nGpXozRCBhPYrgrCgk19WAAP9fieFyg6gBeC/UrXJJxuP82jfhlxu7b6IPA/0+/oBqWTntlqK3EaudpgZoG5D6s0pZXeY3bFjPuNhQ8TfmmC6I4w8D5lmKGI99dKmdZxFTgm+8AcHuWumAqmQPQLkovWQ34u0AuHPyIuuuYkTPA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by SA3PR13MB6394.namprd13.prod.outlook.com (2603:10b6:806:380::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Fri, 23 Jun
 2023 05:36:03 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e%5]) with mapi id 15.20.6521.023; Fri, 23 Jun 2023
 05:36:03 +0000
Date: Fri, 23 Jun 2023 07:35:51 +0200
From: Simon Horman <simon.horman@corigine.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Choong Yong Liang <yong.liang.choong@linux.intel.com>,
	Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
	David E Box <david.e.box@intel.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Mark Gross <markgross@kernel.org>,
	Jose Abreu <Jose.Abreu@synopsys.com>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Wong Vee Khee <veekhee@apple.com>,
	Jon Hunter <jonathanh@nvidia.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Revanth Kumar Uppala <ruppala@nvidia.com>,
	Shenwei Wang <shenwei.wang@nxp.com>,
	Andrey Konovalov <andrey.konovalov@linaro.org>,
	Jochen Henneberg <jh@henneberg-systemdesign.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	platform-driver-x86@vger.kernel.org, linux-hwmon@vger.kernel.org,
	bpf@vger.kernel.org, Voon Wei Feng <weifeng.voon@intel.com>,
	"Tan, Tee Min" <tee.min.tan@linux.intel.com>,
	Michael Sit Wei Hong <michael.wei.hong.sit@intel.com>,
	Lai Peter Jun Ann <jun.ann.lai@intel.com>
Subject: Re: [PATCH net-next 3/6] net: phy: update in-band AN mode when
 changing interface by PHY driver
Message-ID: <ZJUvNz7xOV8kCOgP@corigine.com>
References: <20230622041905.629430-1-yong.liang.choong@linux.intel.com>
 <20230622041905.629430-4-yong.liang.choong@linux.intel.com>
 <ZJReJ2yxqKGQx1BU@corigine.com>
 <ZJRjd0oqj95U0nHc@shell.armlinux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJRjd0oqj95U0nHc@shell.armlinux.org.uk>
X-ClientProxiedBy: AM8P189CA0019.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:218::24) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|SA3PR13MB6394:EE_
X-MS-Office365-Filtering-Correlation-Id: fae67e4c-49ce-470c-3043-08db73abbbde
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fuMPQVyrfDifQvOtTSRM8r5BONnSYWfk/5aknEo3ywGKNg9WO17Jw+teUo6p1H0hW/3IG3UikSM/QtDVnz0LVRU4kN+k/aNW/KGbWgeoU0dsC/2Q7duEohZFRU1XZQkutqAytYR/xh5kgkcc2bCq60PYBTxq4GvOSp8iHo996zSfCl/i4//QC5fGxyuYtb68Cr2SYmP50yrQ0dPx0lh1KvgFF19SOFIQz8bUb2CYwVpwMEmqM4Lm0sAEDYaW/re1jGH3JI4xOc5Ly1vh1o53S0uObvmERGu2LMGGEkllwxsGduone6sby/D5sjMBmkIOT9wApJXjcnQFXbjZa0b62XGjqGmhHzSH/tED/SYi1svsqxiZt8vQqPn56mmutCjZK9T7OKZql2oEZ1A/b4Lor5gO+BY9nnboQyxd9Lj3dz1itwzEIBQbnSIjtbknZ4Kz98+Vm7GHp0Oc+SMXtq5vIr4vUgG6PpvMU6SrJ8qpbp2izjVOEBbC3Bb0zWy2IpdLnRdizKVhIuIzxq0M0xO7AnRtwC2uW9Tyx2DlaJbhVzeSVozsUL6a1MJJNVJk4MO1dAEg8y3z4O2GYJSKCQPo+f10RoovK5ccRPAT7M32NUA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(39840400004)(376002)(346002)(136003)(451199021)(4326008)(2906002)(478600001)(54906003)(86362001)(6486002)(316002)(6666004)(41300700001)(38100700002)(83380400001)(66946007)(36756003)(6916009)(66556008)(66476007)(2616005)(6512007)(8676002)(8936002)(6506007)(7406005)(15650500001)(7416002)(44832011)(186003)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bZn4jy0oQOUwGRbY8LuQSSx7iK22lpGwEA6Ro0pvUxd8/ytUYTfRRxXDquhR?=
 =?us-ascii?Q?Yyb+6P7D9g2RoB9q9RPYWNcbVFjZGnZo3mnpmnyR1czdd72jF4+hnlNc+JT+?=
 =?us-ascii?Q?AE4Ztm39LuSyKRlHpHCgffJJEIR4mFAmiTNsmdqibSeB+FQRgJcF1D3jYFFR?=
 =?us-ascii?Q?LaYygLrAZXU2tXdtYG6GNvKCJz4SBdUhlNEmTa2GxN7+NYSJ27ePtgDCh37h?=
 =?us-ascii?Q?+WnflBPqoN+W+jD5lOEpOPBE/SRXWttrZ/yycbq90fB4CuQ5QFJ3+E263H9U?=
 =?us-ascii?Q?WfCctNC4lMFE2lZKHUb+YJUjqPd1sfkIcNRCbrF13r7hT9JKdsyrYjNQyJaE?=
 =?us-ascii?Q?d/d3n9UvyzFdvB5Nf2ZBFG430Dt90dnGTM/zRMkVxjRtgq+wqEbWZAybFGsP?=
 =?us-ascii?Q?AJG6CFvjHKagS/D50KofWebDQWUmbXg55YUe75XUguUZGYZnhMn2WprZiJrX?=
 =?us-ascii?Q?0aIPgL/jHTc5KnoBWfhmwI2FMwHs077p2W4ozFJEkTpZaMPrjqne3Ek29AeD?=
 =?us-ascii?Q?uGOvM37VpXjvBtvXGo3XNdYefXyY1ltJNIz+5v247MVt4SOjd3AJsEQ2BVme?=
 =?us-ascii?Q?PJ5R61GnHFRZUjyXMwMYSSr8ABy21o+g/lyrrrRIR7SSOYHSgkCQ4YFhxVhH?=
 =?us-ascii?Q?944txhmqHACgvn4NcdBCxlCi867NYd0s5ZpBCSoY8MrFYplQTirB+vM/NJa9?=
 =?us-ascii?Q?2aWqvz7l4bbno1m4Cciuknxd37egbx7740xzSdmz61dXBxPpxcAEiKf2BNmk?=
 =?us-ascii?Q?4Ak122mci8kWQPJfNMi4gxhGC8dUK2LX5QGioGpZBmA9bywILIF6e4FIYDh+?=
 =?us-ascii?Q?N0S7zGxaJROrnbWohSqO0M5LSyhSr/F26ntAs/K+uPURgJtYHDGC76qrblcd?=
 =?us-ascii?Q?QZxQmYKfeZz9vrv9Sdlsofpm6hhKpDtQ7dLqLWrlpZKotCFQcOX9HTJvACWi?=
 =?us-ascii?Q?t7a25wuQ1uIbFuvyQAZ7Z55PEmpNlepB5fhRkX7lkjm4MlhPeDnQu625LRTb?=
 =?us-ascii?Q?FwV9F0cj4HTK45UE4tasGZfDzrAI71yuCmT0P9A6Hb9bD/pKaFwk2pI47bfm?=
 =?us-ascii?Q?W5GRGTozOx+i/Plj4uBaoLPftSLvgoAsmEBF3yMv43NJGEUzh5M4JK3cw2uS?=
 =?us-ascii?Q?OaafqezJfGpLhlFbFvl3vVFmq9mzzkKMogHZ0ZfnHaGInZQ3YT/agatGVQ5O?=
 =?us-ascii?Q?cRUgoxwN/S2hNadTfEJkXem4ff1gx+1ySn87t4HVLo7G8Tnt4Va0uPUyo2wF?=
 =?us-ascii?Q?o3lUYKsxtJl0j26gNbiaymlOmgxLM+6ahcIoE9gMOOWwRGOD4Xih/zuTwzej?=
 =?us-ascii?Q?DCTOX1C7SjbGFhes7ebK+WcDvjcvjuk0iguD+spD09pyUQr47QSJngwEc/t5?=
 =?us-ascii?Q?DutNMsxJ9sVALP09gqWeeEyYNMAfBLw8PDp+cVkYVNj4yhBsOU8mwOhc82I7?=
 =?us-ascii?Q?/ZM8hVOaAWSmzoJ8ejPITpCq0ubSyk70k+SJi/Plnu3Ka3KeMRDVIWboKAXt?=
 =?us-ascii?Q?raNocpHHpCQSQnfbNHdRavVXn1nOy+oUJ+swT3zqfZCnKMHKoQNVfcUt49nI?=
 =?us-ascii?Q?f8+gVAxLYOjxt9tDgi8DrUHcwq6D33m9Cs7zvMACDK/1tXsHXqEk7V0qJ0Sq?=
 =?us-ascii?Q?wM+o6BBAzlkHtlIc57d7sIHpu4MkYqDKmKzuqmxtX4IODaXAv8F7TAKorPoQ?=
 =?us-ascii?Q?kraCyg=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fae67e4c-49ce-470c-3043-08db73abbbde
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2023 05:36:03.4226
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MRg0Xp1Gs6cyLsftAAoxWmIHl8zzqxxQ05EA5Oe9y5sd4RRH+TS6t6vwMKyQIFIwW+FKWA6PRRY10V5KYLN5IJUPrAJoLMpPmbag6JQ4Yao=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR13MB6394
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jun 22, 2023 at 04:06:31PM +0100, Russell King (Oracle) wrote:
> On Thu, Jun 22, 2023 at 04:43:51PM +0200, Simon Horman wrote:
> > On Thu, Jun 22, 2023 at 12:19:02PM +0800, Choong Yong Liang wrote:
> > > From: "Tan, Tee Min" <tee.min.tan@linux.intel.com>
> > > 
> > > Add cur_link_an_mode into phy_device struct for PHY drivers to
> > > communicate the in-band AN mode setting with phylink framework.
> > > 
> > > As there is a mechanism in PHY drivers to switch the PHY interface
> > > between SGMII and 2500BaseX according to link speed. In this case,
> > > the in-band AN mode should be switching based on the PHY interface
> > > as well, if the PHY interface has been changed/updated by PHY driver.
> > > 
> > > For e.g., disable in-band AN in 2500BaseX mode, or enable in-band AN
> > > back for SGMII mode (10/100/1000Mbps).
> > > 
> > > Signed-off-by: Tan, Tee Min <tee.min.tan@linux.intel.com>
> > > Signed-off-by: Choong Yong Liang <yong.liang.choong@linux.intel.com>
> > 
> > ...
> > 
> > > diff --git a/include/linux/phy.h b/include/linux/phy.h
> > > index 11c1e91563d4..c685b526e307 100644
> > > --- a/include/linux/phy.h
> > > +++ b/include/linux/phy.h
> > > @@ -756,6 +756,8 @@ struct phy_device {
> > >  	/* MACsec management functions */
> > >  	const struct macsec_ops *macsec_ops;
> > >  #endif
> > > +	/* For communicate the AN mode setting with phylink framework. */
> > > +	u8 cur_link_an_mode;
> > >  };
> > 
> > Hi Choong Yong Liang,
> > 
> > Please consider adding cur_link_an_mode to the kernel doc
> > for struct phy_device - which is above the definition of struct phy_device.
> 
> This looks like it's grabbing something from phylink and stuffing it
> into phylib.  However, I have no idea, because I don't seem to have
> received the original patches. I'm guessing the reason is:
> 
> 2023-06-22 05:21:24 1qCBoy-0003ji-G9 H=mga03.intel.com
> [134.134.136.65]:57703 I=[78.32.30.218]:25
> X=TLS1.2:ECDHE_SECP521R1__RSA_SHA512__AES_256_GCM:256
> F=<yong.liang.choong@linux.intel.com> rejected after DATA: unqualified
> address not permitted: failing address in "Cc:" header is: Tan
> 
> Which I suspect came from:
> 
> 	Tan, Tee Min <tee.min.tan@linux.intel.com>
> 
> and someone doesn't realise that a "," in the display-name part of
> an address *must* be quoted, otherwise "," is taken to be a separator
> in the address list.
> 
> Consequently, it has now become:
> 
> 	Tan@web.codeaurora.org, Tee Min <tee.min.tan@linux.intel.com>,
> 
> It should have been:
> 
> 	"Tan, Tee Min" <tee.min.tan@linux.intel.com>
> 
> with the double-quotes.
> 
> Please do not review this series further, but instead, please can the
> author repost it forthwith with correct conformant headers so that a
> proper review can be undertaken by all?

Hi Russell,

Sorry for not noticing this myself.
I agree that we should wait for a properly formed post as you suggest.


