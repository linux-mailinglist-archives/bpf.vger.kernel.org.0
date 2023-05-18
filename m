Return-Path: <bpf+bounces-915-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36C47708886
	for <lists+bpf@lfdr.de>; Thu, 18 May 2023 21:42:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 155F21C211BD
	for <lists+bpf@lfdr.de>; Thu, 18 May 2023 19:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9089134C3;
	Thu, 18 May 2023 19:42:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56FE33D38F
	for <bpf@vger.kernel.org>; Thu, 18 May 2023 19:42:24 +0000 (UTC)
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD8A5E72
	for <bpf@vger.kernel.org>; Thu, 18 May 2023 12:42:22 -0700 (PDT)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 8F099C1519AF
	for <bpf@vger.kernel.org>; Thu, 18 May 2023 12:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1684438942; bh=kiYOW9g5ZEj38Zr03cZOOO5o7uETuT/lrxb8BviTyrw=;
	h=To:CC:Date:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kIgHyGjz6NxzHYuLeI8CRJs6rprRboZt7yQQM0RMQWZXGkGloWaQvxoXs4RwnZerF
	 90Xl4JOljJ3N7SiN73XTt2q8XF0klPE/SyYBNlvx0r3n4PuJDJzUvAIgIgFgYGasCJ
	 iP44It8HWNnsyggpyFW2wz7LFJPRgr3n+vKXrNjE=
Received: from ietfa.amsl.com (localhost [IPv6:::1])
 by ietfa.amsl.com (Postfix) with ESMTP id 7A38FC151075;
 Thu, 18 May 2023 12:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
 t=1684438942; bh=kiYOW9g5ZEj38Zr03cZOOO5o7uETuT/lrxb8BviTyrw=;
 h=From:To:CC:Date:References:In-Reply-To:Subject:List-Id:
 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
 b=LH6zk0sZp0yOdHaEncmBfYFCktL2SDmXqG/JJ91Dqou3IKOZTV42xdsSz5Q/Wv4O1
 WyBi+r3FUMDMg6wR6S/IXkjqvShWaySUexkk0RhBymkrvO9vY4jvls0Ab3UJUGVAdO
 NBNFPYAEYXGHeenBcji7yNbklasfMd3S58l8ot4M=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id AE0BBC151075
 for <bpf@ietfa.amsl.com>; Thu, 18 May 2023 12:42:20 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Score: -2.099
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (1024-bit key)
 header.d=microsoft.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jyOfISe-wymc for <bpf@ietfa.amsl.com>;
 Thu, 18 May 2023 12:42:16 -0700 (PDT)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2072e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::72e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id CA881C151060
 for <bpf@ietf.org>; Thu, 18 May 2023 12:42:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oF2GifV923LkszPToeGFSF76pscje6CQn5I+Wthp/VJXrvRow/s/lXRAn7Fc0s64gXoE3Q4q4aEEsXpCzVEO4+LZKk/qxZewZYn+TpSpabZnsywaLLEFcQuOuG44JO3Pp1JcjNQH582LZUn1R8je2lZbZuL6kwscC80oyx/1fcrOYTuznbgmsZ7t11BtgyT4Y8023JyepegzWKk6lx6WqtTzqME2c4ObxAH7KE9nk2YwG7mLq3dSGQZKAhJSt/yKMoOlFhYPG3l6R+ZtYVmWVF3P/utCzDVgERb2gl7GmpvQGxmEsJBfmJ7D2xK5bu1BKHYmmHfg8Arqoen9+Gj4hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n6tAselGX29kBGBptCs8nlFp33k8q8G+1IGvB+EoOpg=;
 b=hsu/djSIG7EB1fIa2U9xG2knH+Ws0CZGohNzou4ALKKF0ycq8IMCu7Rw2FdQj8rTPfQt3cj7pKKWnVrKlr5d7SpCmoxWkxOsFEjSy3JRGslEUI6GIX773ZEdn1MipypfBMN3KJnAX0ClMFsGJkHeMpcEUtbg2bz/SVsmmPG1BNjDdHJojLJOGEDS/esLl1jk7QGVQMU77Wemn/vjOq9+/scSOFjHd/xrETU4Qvuy1DvshUcoK3+uOrRv+mQiFCfHpwIC6rQqsP/dEP0qtk/reNC4pSZD2ywpVxeaBIEVLC3SBW7BMbDVLrmW4LlBOr8bXdM7aDuJa9G5n8bt4LMyXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n6tAselGX29kBGBptCs8nlFp33k8q8G+1IGvB+EoOpg=;
 b=Mu9sGsxqfsldiD6B1nvFWMbFh9pDewci32BafYQnSRmqnB1zcfJ363EFSlCc92ALXPdQnDrvPthefkisyS/cX/KXa349mBAdZ9abcvmRnM8CgvYbotcYgnM/lpIlzRPu5n53VnZpqZopgPpOYVsPxTbpYmiT7hUcgANYWuGRBik=
Received: from PH7PR21MB3878.namprd21.prod.outlook.com (2603:10b6:510:243::22)
 by DS7PR21MB3527.namprd21.prod.outlook.com (2603:10b6:8:90::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.4; Thu, 18 May
 2023 19:42:11 +0000
Received: from PH7PR21MB3878.namprd21.prod.outlook.com
 ([fe80::ebee:52ea:94c9:4e43]) by PH7PR21MB3878.namprd21.prod.outlook.com
 ([fe80::ebee:52ea:94c9:4e43%7]) with mapi id 15.20.6433.000; Thu, 18 May 2023
 19:42:11 +0000
To: "Jose E. Marchesi" <jemarch@gnu.org>
CC: "bpf@ietf.org" <bpf@ietf.org>, bpf <bpf@vger.kernel.org>
Thread-Topic: [Bpf] IETF BPF working group draft charter
Thread-Index: AdmIWSmp8uIYgrASRIKQXfLbLZQgdgAeO2knAAYWUOAAMSGf+AAD196w
Date: Thu, 18 May 2023 19:42:11 +0000
Message-ID: <PH7PR21MB3878B869D69FD35FA718AF5DA37FA@PH7PR21MB3878.namprd21.prod.outlook.com>
References: <PH7PR21MB38780769D482CC5F83768D3CA37E9@PH7PR21MB3878.namprd21.prod.outlook.com>
 <87v8grkn67.fsf@gnu.org>
 <PH7PR21MB3878BCFA99C1585203982670A37E9@PH7PR21MB3878.namprd21.prod.outlook.com>
 <87r0rdy26o.fsf@gnu.org>
In-Reply-To: <87r0rdy26o.fsf@gnu.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=16f22bd5-2b9f-4b12-91c1-e961bbe42adb;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-05-18T19:24:17Z; 
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR21MB3878:EE_|DS7PR21MB3527:EE_
x-ms-office365-filtering-correlation-id: ac79b66a-8ec1-40c5-ca71-08db57d7f947
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SCuVza0dv0QPVmM4BStfRw+2lHIA5W5eclvEhIeuLqudXnBASw0uQFu/r4nY6g16SjiQJ2JiAtYffFEw7dqx6S4bg3Y49oSvtnr1L81T+gh9RLa4FyVb5C4CILOf3AWqKIiJruqbnyKkV2GqSQQAqHDf27M8j2tr2gBISPBJvOlXuOXPmsUCToR8BXA4MEh8WR19kCPmbDrF6HKDRSvYYdETrRg6BbzVEqtQQBmGgcf3x4sCx3+h7X39dD21FdHDwx3UNXpl+BFqDn2mQo43HV22w+sKD8jdfYtW1Ef0ArGO3N0m9Xyfmj3s9HUhT0dxKShE5WZa0b85kLrOQr2+FKriHBKthLPAqVNprUAK8s7xyEPQ+r6WLK+XDO+1ieq54EkRSjMqhkGTfuOiAU/lN7rLLU3/V+lZEH2KlFnMXAU98HTf+yKDXqLBNSyc9/tGzp+HiejrDx94GH838HEaoZySDoIXt84nB2x9R3PzWMZ+0cELKxSq4vbcOsqrg6MbQHz0D0gT7Zg9dKgriTvOcH0wM3+SXB7fWptB1ZCRW/0roTxNCuHGGJt2xId+yaeryNzb+fG7MAEheUCR7IQld12Cyca8JpQI9LIqn7pe1k95ehjVKruS++M0/SImGuelkYD3qbikN+1fTgiVlbki7g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:; 
 IPV:NLI; SFV:NSPM;
 H:PH7PR21MB3878.namprd21.prod.outlook.com; PTR:; CAT:NONE; 
 SFS:(13230028)(4636009)(396003)(346002)(136003)(366004)(39860400002)(376002)(451199021)(2906002)(38100700002)(38070700005)(316002)(786003)(8936002)(5660300002)(8676002)(33656002)(52536014)(122000001)(8990500004)(55016003)(966005)(9686003)(71200400001)(10290500003)(6506007)(41300700001)(478600001)(26005)(186003)(82960400001)(7696005)(66556008)(86362001)(54906003)(66946007)(6916009)(82950400001)(66446008)(4326008)(66476007)(76116006)(64756008)(83380400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XGk1XW4Jyg9fZsDd/N473qVpRxAy6J6+iVeS8pIbmwyRs9iXSTMiHNKkBj3t?=
 =?us-ascii?Q?GI4fTCVbWnQBGch5AUqo/U1nZsqzBHqvcz+uW8+sqTUI1313u3l8+IUQts2z?=
 =?us-ascii?Q?zs9cNM8FzjpffGYCNJSfEmkyplE63mheT77cn6/PoMhCzuEszaYMWnp79AVo?=
 =?us-ascii?Q?f5RZ0g8LutpBsngeAOa5XParOrADGp/0nBi9ecH2WpcCxacvHoU8CBTLozJQ?=
 =?us-ascii?Q?NZG+kjGRy3TIp1wVJiXYfnOukhzwkAr0SL7NZTgbgxLgyXkskJiQBcsVlhSl?=
 =?us-ascii?Q?Up+siIzP4MFzTrZs0aWBFKwyZnoFP8Nwnjb8RLMB+dKmJSFWFko1h8xf9fB0?=
 =?us-ascii?Q?p+ycR+5vXqhRKHCU3TCCQzmZEna+Dwt18ZkgF/YjwMjlDGhdYYIViu/SQYmr?=
 =?us-ascii?Q?kv0q02XsQ/Y5kFmIIvJOySFmgMaLeerxLxYvDDMUlhjDP8NcsrfQvY7x2tkY?=
 =?us-ascii?Q?nTbiipxJv/eS3xmeGil+iqgoy/8kRbjy+vEXeftNNXbVom72UTl4OK/Vs9lP?=
 =?us-ascii?Q?dxtZRs0K8WYeib7/fD1AqzJ4sdDN2p7ijHMEyZ35pEEvUVYqDINVQ9Gn5QjM?=
 =?us-ascii?Q?eOJwlW4mwfZMOuuCl5WCAntvnSw5A+qORNLj9HkXWRY2fhutWVn09zEMjOD7?=
 =?us-ascii?Q?0ynjfMknr2HtsxoGO6Y2RRFDs8ozPRDWlbPsXEHJ54e+HwGiDtepRk5czN4H?=
 =?us-ascii?Q?mL58px4wNad4dX6EAMfQUGckm0qVw0jxP4XzgLXTzKtfymbKXqgnSG2rQpvi?=
 =?us-ascii?Q?YEIpaF6EnrJ4UaQhnYqsuyoll+uPTH3xX1u8wT8D6ohAppyeTeMgO3sc9gI9?=
 =?us-ascii?Q?V3iVFsOJQBbX/kyOfpgbX3wrWshox9lIW9ukOhr/28n5356i6Ln2X5GdGvTE?=
 =?us-ascii?Q?tTBwfh3Lg1G75U1pm4hgsr1wwHJryjg9afHaZgPFL+FwEqbN9Cu1gYxYsic0?=
 =?us-ascii?Q?AMt0lPsMFA0ReDnsSUdNKovP1/qs4whXbjzkGW/Yu67uhdpgA4BfT1pjd5t8?=
 =?us-ascii?Q?2oZ75YhATUs1OSubI2p9NFt2JHpoLu6ugTomHHCvAmy7gYQPUZM7iTA+Ha3D?=
 =?us-ascii?Q?Ja+iVScjFevwV5gagc/uDr4DXfowbCMdSCfkysgHVVTUxouFXFeptaRzntu9?=
 =?us-ascii?Q?7J6KhS8QMJ2FdKuMTumUOdBWhw4kLag5ZOON9awluS+soWkuf5oOAqV7Cetd?=
 =?us-ascii?Q?1ElYPvRTmqNi8W7e/HGMTdTQ9jflrfk7Ww/2Z8C/+xCuMRv+nvUGn+h4KM+h?=
 =?us-ascii?Q?kw0breDr47PpHFJ/XnIbq46CWemskDU28M9DzppB8kf0FyQsyRhF7+vkXou0?=
 =?us-ascii?Q?xVf7O0/xcU9p2mfMmMGZuidzAgBrYw1x/qzvyiHij/+Fbfk2KeLdmL73m9Of?=
 =?us-ascii?Q?80U8KvyKbJMzx/5ASqlEh72bihn2W/bmutB98wmWbtenovA2yaGtzS5cekhq?=
 =?us-ascii?Q?AoPyA3o8OfZ6+boYz5l0tF8k/IexXG1xL8b0vQwqpouh7qQpZpdFOAHcB0vC?=
 =?us-ascii?Q?LdhoFICOZErRQ7SlJwRMNZu1bS80HLfDvz86yTRVbL5a+by+uUobJ35C3EdF?=
 =?us-ascii?Q?cjI2loA8/M3SBKHmxtWcY0INx9XXvGCmfZlx6k9g30N46X0Ph2Zon9sUFdP+?=
 =?us-ascii?Q?7A=3D=3D?=
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR21MB3878.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac79b66a-8ec1-40c5-ca71-08db57d7f947
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2023 19:42:11.4724 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HVM+/Js+N1vwtrKBRIVAOyjYJ0SO6WUpklwCFZQ6l/aKKzbTXAUSQwGdg2sKGINeMbZcPScYWOzJ0PN5xlLaZvA16Myj/LAHWnxXpPO7yJg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR21MB3527
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/Hc-dDOysYYub351ke3gCvSDVEiw>
Subject: Re: [Bpf] IETF BPF working group draft charter
X-BeenThere: bpf@ietf.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: Discussion of BPF/eBPF standardization efforts within the IETF
 <bpf.ietf.org>
List-Unsubscribe: <https://www.ietf.org/mailman/options/bpf>,
 <mailto:bpf-request@ietf.org?subject=unsubscribe>
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf/>
List-Post: <mailto:bpf@ietf.org>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
List-Subscribe: <https://www.ietf.org/mailman/listinfo/bpf>,
 <mailto:bpf-request@ietf.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: bpf-bounces@ietf.org
Sender: "Bpf" <bpf-bounces@ietf.org>
X-Original-From: Dave Thaler <dthaler@microsoft.com>
From: Dave Thaler <dthaler=40microsoft.com@dmarc.ietf.org>
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Jose E. Marchesi <jemarch@gnu.org> wrote:
> I would think that the way the x86_64, aarch64, risc-v, sparc, mips, powerpc
> architectures, along with their variants, handle their ELF extensions and
> psABI, ensures interoperability good enough for the problem at hand, but ok.
> I'm definitely not an expert in these matters.

I am not familiar enough with those to make any comment about that.

> >> - Open to suggestions and contributions from the community, vendors,
> >>   implementors, etc.  This usually involves having a mailing list where
> >>   such suggestions can be sent an discussed.  Almost always very little
> >>   discussion is required, if any, because the proposed extension has
> >>   already been agreed and worked on by the involved parties: toolchains,
> >>   consumers, etc.
> >>
> >> - Continuously evolving.
> >>
> >> So, would the IETF working group be able to accomodate something like
> >> the above?  For example, once a document is officially published by
> >> the working group, how easy is it to modify it and make a new version
> >> to incorporate something new, like a new relocation type for example?
> >> (Apologies for my total ignorance of IETF business :/)

My point in the options is that a standard can be constructed such that
adding a new codepoint does NOT require making a new version.  That's
the point of things like IANA registries.   So yes it is straightforward to
accommodate _without_ requiring a new version.  One only requires
a new version if there are actually errors in the original, or the original
did not allow an IANA registry or other process for codepoint allocation.

> > There's 3 ways:
> > 1) The IETF can publish an extension spec with additional optional
> > features.
> 
> I don't think adding new relocation type, as an example of the kind of
> changes that ABIs regularly are subjected to, qualify as "additional optional
> features".

I'm not familiar enough with existing ones to comment on those.

> > 2) The IETF can publish a replacement to the original (not usually
> > desirable)
> 
> You _will_ need to update that particular document, and probably quite
> often.

I'm not convinced of that.  Indeed that would be very unusual in the IETF.
Rather the IETF has established patterns of writing documents that obviate
the need to update any single document quite often.

>   jemarch@termi:~/gnu/src/x86-64-ABI$ git log --oneline --since="May 18
> 2022"
>   b96eaf2 (HEAD -> master, origin/master, origin/HEAD) Remove MPX
> support
>   ab1bd26 _BitInt: Update alignment of _BitInt(N) for N > 64
>   43453ea Clarify R_X86_64_REX_GOTPCRELX transformation
>   e2387f1 Add link to download latest PDF
>   b5443bf Fix typo in footnote stating incorrect register range for AVX512
>   8195730 Add optional __bf16 support
>   6c2ac6c ABI: Fix typos
>   8ca4539 Add _BitInt(N) from ISO/IEC WG14 N2763

Going off of nothing but the text above:
* Fixing typos: this is the job of the RFC editor pass to catch anything that
   was missed in the earlier steps.  In theory there should be no typos
   in an RFC.  In practice there is an errata process, but typos are not "often".
* Links to download: Links in references inside the document should be
   to stable references.   Links to IETF documents themselves often go to
   an info page which has links to the various formats of the document
   (html, pdf, etc.) along with links to any errata and IPR declarations.
* Adding optional support for something: this is most typically done in
   a separate document, not by modifying the original.

The point being that in the IETF processes, documents are updated but
it is not "quite often", and the list you cited doesn't convince me that
an IETF style document would need to be updated "quite often".

> That is for a very well consolidated and stable architecture such as x86_64.
> Now imagine what will happen with something like BPF that is still in the
> process of figuring out its own ABI and the way it gets compiled.
> 
> Being very optimistic, would it be OK for IETF and the WG to release, say ten
> new versions of the "original" per year?

My personal opinion: No, I'd consider that a failure of the document process
of the WG if that happened. I can say I've been participating in the IETF
since 1994 in many areas and WGs, published between 55 and 60 RFCs, 
and I've never seen anything that would have multiple new versions of the
original per year.   I don't expect anything in BPF to be more special than
all the other things I've seen.  But maybe it's just me :)

> > 3) The IETF can define a process for other organizations or vendors to
> > create their own extensions, and some mechanism for ensuring that two
> > such extensions don't collide using the same codepoint.  This is what
> > the charter implies the WG should do.
> 
> What is the precise license under which the document describing the ELF
> extensions and the ABI will be distributed?
> In particular, does it allow distributing modified versions?

See https://datatracker.ietf.org/doc/html/rfc8721 in general, but specifically https://trustee.ietf.org/documents/trust-legal-provisions/tlp-5/ section 3.

Dave

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

