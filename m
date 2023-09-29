Return-Path: <bpf+bounces-11138-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94E4D7B3BBB
	for <lists+bpf@lfdr.de>; Fri, 29 Sep 2023 23:03:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 4754E2832EB
	for <lists+bpf@lfdr.de>; Fri, 29 Sep 2023 21:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F5E46726C;
	Fri, 29 Sep 2023 21:03:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54549521B5
	for <bpf@vger.kernel.org>; Fri, 29 Sep 2023 21:03:29 +0000 (UTC)
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 813E21A7
	for <bpf@vger.kernel.org>; Fri, 29 Sep 2023 14:03:27 -0700 (PDT)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id E7C2AC1524B4
	for <bpf@vger.kernel.org>; Fri, 29 Sep 2023 14:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1696021406; bh=eFXLVn9hA7KY1YsNf9EQmrsNcJphjaYDS1OVy8Bo/Vo=;
	h=To:CC:Date:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wFVaezndmcEkjyHp4BLG7Q6bl6vFUJMhyYHcivAGB1+TNTiBMrm88jF/LEC1fCPy7
	 qtm54du2+CReiGqw47Deri1/+1djYYRZ7LzgKgF5LcvtLO4bkM+EfDkq+QAPawnr58
	 JPJILmsyZMonbqcFsvqJTh0N3RMIqd4T3KBQKAXU=
Received: from ietfa.amsl.com (localhost [IPv6:::1])
 by ietfa.amsl.com (Postfix) with ESMTP id BC1D5C1519BF;
 Fri, 29 Sep 2023 14:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
 t=1696021406; bh=eFXLVn9hA7KY1YsNf9EQmrsNcJphjaYDS1OVy8Bo/Vo=;
 h=From:To:CC:Date:References:In-Reply-To:Subject:List-Id:
 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
 b=GW+uY/gE1C59tAe48xgF7qzXTjC6+TNIi2VlZackNCw4q7l/jWWwNSmBrtnarww0M
 3EWyS/uIvfS6bQmWuy3CDlA5zTi9RHhv4xGlQMrht0EeqNEhUt/qAkmgzi4nYLxDa8
 yj8i6RffmtKc9QWDoYYGoUXDOG2tp2l+MmG2Hw24=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 579C8C1519BF
 for <bpf@ietfa.amsl.com>; Fri, 29 Sep 2023 14:03:25 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Score: -7.109
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (1024-bit key)
 header.d=microsoft.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gM2PakOZCqrA for <bpf@ietfa.amsl.com>;
 Fri, 29 Sep 2023 14:03:21 -0700 (PDT)
Received: from BN3PR00CU001.outbound.protection.outlook.com
 (mail-eastus2azon11020014.outbound.protection.outlook.com [52.101.56.14])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 33B87C1519BB
 for <bpf@ietf.org>; Fri, 29 Sep 2023 14:03:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=irPSuL4ae/vlsQtrOXXvzNHSBG5z5tOK2yEhFxPbotHaAiGz90/4biZBsXpk8ZhjtOaYDCA4WW9athya6leXG5EDg1ONSd4M0wmPJuEZiqa7UBTt5d8ZZQeRcS8nX0mG4IQRTI2uLPH7sz+y+gMbXH7l2Z+BJPgMMEllvd17fwcTD2OlKfN690aVIvrtpERNUVXYEQ0FGFDmxsw5voe0N/MSf7q56rtKPtUOz6mO502ynAPI85Kr840pAP9XJ7ml26j7lIJ+SrTIIHNj5KIk6vLMowTlyoiLUQvWAnecGu5Gp1Ng/dAc+gZC8HnHyoXUek+K+dPWCgcpn1CEX5BvFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hgZg/Nku+VsvJh1T+ZQLrpNf5gpHOOg8/b2mdqtLOxw=;
 b=ZnG08TmuAIQlRBml+9RBmHahjMmUQgJuH+lmsjAfPPtGqy0dCs+4H5AoKCBBQG2DpBfPLej6SbeZbQH6ivB9/z6Zn2ViD0bZR7dSg/2KQLAdTjijbzlGo1+PHd2yhn1VYrcgC0awDjZi9+qtChZElw2oCDvy/wdLmGTB1YOKi+3HEtroYE50w3cBX4p5ovzmkhCUUI4uLRFrrwtcy66xslU04GCnWNJNXJdpjf/4aTr9H4s03sjtHWH3CfFDrY76/+ujE8xItRXI8/7Ws5EqL5sBxArJuzUtou0rCKSOBLoQW40JZjPgY8j1lnwVfUTpjO1/LyPp7ERVViTZaodN+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hgZg/Nku+VsvJh1T+ZQLrpNf5gpHOOg8/b2mdqtLOxw=;
 b=UC7gbH7pMvYPAw4V2ZRRPcEZHtzP+bA4pMmdYmoRXZdRSUP3ogH0FBEN+LjMY2Lo+ghbqsk5xO7hPpCZ5+t3wgf0dLdcxuSBA8VFzrvvnj38tS1qir2vO2/MtkzJMIZcbI5ekDMFZsCHN20Ioj4BlxokB4HGvbXmrFhBujAQMoE=
Received: from PH7PR21MB3878.namprd21.prod.outlook.com (2603:10b6:510:243::22)
 by LV2PR21MB3398.namprd21.prod.outlook.com (2603:10b6:408:14c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.12; Fri, 29 Sep
 2023 21:03:17 +0000
Received: from PH7PR21MB3878.namprd21.prod.outlook.com
 ([fe80::ec5c:279e:7bfe:50e9]) by PH7PR21MB3878.namprd21.prod.outlook.com
 ([fe80::ec5c:279e:7bfe:50e9%3]) with mapi id 15.20.6838.010; Fri, 29 Sep 2023
 21:03:17 +0000
To: "bpf@ietf.org" <bpf@ietf.org>
CC: "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Thread-Topic: Signed modulo operations
Thread-Index: AQHZ8xhezjXHV8CmzkqNy5GI26QKLg==
Date: Fri, 29 Sep 2023 21:03:17 +0000
Message-ID: <PH7PR21MB387814B98538D7D23A611E89A3C0A@PH7PR21MB3878.namprd21.prod.outlook.com>
References: <20220927185958.14995-1-dthaler1968@googlemail.com>
 <20220927185958.14995-7-dthaler1968@googlemail.com>
 <20220930205211.tb26v4rzhqrgog2h@macbook-pro-4.dhcp.thefacebook.com>
 <DM4PR21MB3440CDB9D8E325CBEA20FFA7A3569@DM4PR21MB3440.namprd21.prod.outlook.com>
 <20220930215914.rzedllnce7klucey@macbook-pro-4.dhcp.thefacebook.com>
 <DM4PR21MB34402522B614257706D2F785A3569@DM4PR21MB3440.namprd21.prod.outlook.com>
In-Reply-To: <DM4PR21MB34402522B614257706D2F785A3569@DM4PR21MB3440.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=17d2a68b-d1b9-4c64-b84a-8c7414aa9153;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-09-30T22:38:54Z; 
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR21MB3878:EE_|LV2PR21MB3398:EE_
x-ms-office365-filtering-correlation-id: 191e2c5f-8975-4adb-1159-08dbc12f80f0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rWOSt8kujpZ9bP3D4ObG2M8o6poo8xGAA6sU1zovMgUiext5AXe+APSMZa/36/hHsTx6JBFLa80hJHhp1i9hxXqwh1D9nzKzGUbR3yhKhvtAP4syW+o6jyeBLuPiN++1kIsvhpgaV2W151Ms0cus0f7VRCM85f0T9Ok/DJeR9AtZ5SHnCnRaB1gBBJEPUmGRje5C51QUKCjpKZRaV2hrAMy9uKhoDAzzJ0nX55tAF1JmrJRmBuz2ZIU6B0LDapxRJENrpVXQ090U0/4ZPt1La4MDXmsnllPIlSBX0Ef+K7hpOQJcMvNxGzJMOIH5beWQmASUymbUxQR7rW5XNz8SPnJkqolsUR09U1Qca94LshsWI3SXSFV7C/S7xZy+c8uBrdZ0KS+DVYSCdcWESc28XWemC30AzrB4re7FH73e3FSFTBnMTE6hMTt3IRpcIiICuTiupwysW1sN/UgGYiA9TBRXo7CK5gMVv5VuPgn2bR42HBaR4w0u+klg3BRYpZrGL9HqG6RrzkoB+OQBOCehCRV+tP/6pPca9gM8EWMhAamQFvVf5ZwE30J0vFVGjKnImIqQyRVDP8qayL3jmFatCf7pn8AYix7gvYeRtTjegXLuPj2JNjEV0PYPBcg8mImxsmm22Dzd0UYYump27HyTpQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:; 
 IPV:NLI; SFV:NSPM;
 H:PH7PR21MB3878.namprd21.prod.outlook.com; PTR:; CAT:NONE; 
 SFS:(13230031)(376002)(136003)(39860400002)(366004)(346002)(396003)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(83380400001)(3480700007)(7696005)(966005)(71200400001)(82950400001)(478600001)(10290500003)(38100700002)(41300700001)(86362001)(8990500004)(2906002)(33656002)(82960400001)(53546011)(316002)(66476007)(64756008)(66556008)(76116006)(66446008)(66946007)(6506007)(122000001)(6916009)(9686003)(55016003)(38070700005)(26005)(4326008)(8676002)(8936002)(7116003)(52536014)(5660300002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8Olu5/3FxswgUxUQVn4cnDiuWt8olQlT/YSyKFicTL3RVsRjP0l2366f3LEJ?=
 =?us-ascii?Q?cSKTW9kBvEevk21m+Ucq/2P1/a3yCEpwDUKq00MBtb6TJkk2aS+2KlhjMN0+?=
 =?us-ascii?Q?+ygDvmIYw+EYqx9Ir9i6FsUvX6+AewCmPTf8A83IM/ymU+ZhXDOLEUc2yt31?=
 =?us-ascii?Q?BL2ETmj4uEmTZ8kitpg/KcITqlDeCC7Y5O4ycbym/MR+blaZ6mzkHMFKoydm?=
 =?us-ascii?Q?kYxJWnkdpNqZ4OZTDF1dguNOc/iqhp0NdOq9zAWaGd68uiR3BvAtnjLY6QpW?=
 =?us-ascii?Q?5Jf4C0QHORzVJH2kBb0XPyc0td9TN1pHGMxbx7Qb6A4T+rJ0IUVZe3VEvk/p?=
 =?us-ascii?Q?HZCHunKZ5/aaW5TMUBU6ImO5Uq2mK1PtFC01IaA+xhIA6WZJ6HywJCUYaV8T?=
 =?us-ascii?Q?NeTIigah2ZtvMKU4LS+95aDFwD3AM7GvXkKp5GdtNfDdEk93zvxYIJlzHdx3?=
 =?us-ascii?Q?NEjrnZI9LlryQwtm/+sNDy/M8Hs1Ir+KUsosJUYmza5ppKASVUpj3S2cWWNO?=
 =?us-ascii?Q?MzmFJiekvx0WlfOBETMm/BuvSqR79q0jeQG3N0OjfUs+KiEnBwk0bwuvzeBy?=
 =?us-ascii?Q?/8X99/as6C8dgrhCK7C/5EAmQXlhY39byRFbTNja9hlBp6MkAKnApwWfVHPD?=
 =?us-ascii?Q?i6ORaRtGqeiCewlV7zDMTEY5eqB8VoRpEfOb30om7MdZckpspC1Szd9gIByg?=
 =?us-ascii?Q?oJJelZKN1LaSbtPM0cTN7m3dXjUApGcv05u4AOlOGffuUigzxCVxJWqw+Ljh?=
 =?us-ascii?Q?kGcsK1GFvza+lNP2HHCUTOQcDIAqn113dckTvez8zGSk1n8Hv9dLVyGRSyzG?=
 =?us-ascii?Q?oze/Gtfig3nlO8eOfT6BnARJZYTjolguix3s6LrYebfppVRM9oLXTqCKs6MN?=
 =?us-ascii?Q?I8budX5xA935ZRcdaR7KlL3Kv2NGK0jJ5KCDeA/bhuf5VTlRmdMrz3Zjgk4r?=
 =?us-ascii?Q?FSu32U1xkxaBHJBMUdeqjv1EN78pTJRPxKcnkUt1ZCAjE/rKb/tcaydN+xkl?=
 =?us-ascii?Q?vQgFi5G8NZCZAN3aqNcCoT1xQLkUGGTpcxh4Fop3BtJCQsF4huEzDeZ0lto7?=
 =?us-ascii?Q?wzeWvIdIrDQrqO4VtvC3XBvaT6m0uEDA99ARaJi2y6GY1PWIjQutjw8EzpJU?=
 =?us-ascii?Q?bwa+QH/bbyJFJqV8a5cYY60GIqULL/pDt70mWoy4sDRGANXxbTi8PoUH5DJB?=
 =?us-ascii?Q?OfavqormaOBGK1EBSAuIicV3GCwPBJOkmmyONOL5MN6L47QrWlOD9wSd328M?=
 =?us-ascii?Q?YN4S1ZDQGObJT76ZnppODxd5gp9OcsliBuTN7qPQNmWdgWVTFvoN0Ood9O/w?=
 =?us-ascii?Q?G/rxXa76f+sP1DH8Xu7/1wHrMRK5fxFTrzGOJ5rJfmus3MNcQZasF1+0CVGe?=
 =?us-ascii?Q?/Qp+15ER7CPYsXfAfKZV1EF8Rb+jOM3vEwsGa/xanL11GMAlFpmmJRSBCBGq?=
 =?us-ascii?Q?d1iOSvM8NmyhcGn7OXxji8jlMmHAqs6GMdJpblgv4v1AmRakkwSC1Oj3uKyF?=
 =?us-ascii?Q?qCpXQE3A+Jt2l3H+477xZjR8ACty2kOiF5SL+W9toYAQyUreqKDlnkiGgMer?=
 =?us-ascii?Q?lMbHeklDo/Brc20EuYFjFOwiba0TnNivt/xws5j2aS/a+8m/5K0ghJ4Q9AW+?=
 =?us-ascii?Q?CA=3D=3D?=
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR21MB3878.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 191e2c5f-8975-4adb-1159-08dbc12f80f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2023 21:03:17.3601 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: itZr7TS4RaJeZ5WLyxxlFgpE8P4AEU0p048AP0i0yYr0QdmBY5UEqOHztacc+tQSCAGbCwl6axIrz2hqXrXg0BTCo2QDIWN555h5rk9MZdM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR21MB3398
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/ESn-gY31ByP7f7g4NopHEFbTafo>
Subject: [Bpf] Signed modulo operations
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

In the email discussion below, we concluded it wasn't relevant at the time because
there were no signed modulo instructions.  However, now there is and I believe the
ambiguity in the current spec needs to be addressed.

> -----Original Message-----
> From: Dave Thaler
> Sent: Friday, September 30, 2022 3:42 PM
> To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> Cc: dthaler1968@googlemail.com; bpf@vger.kernel.org
> Subject: RE: [PATCH 07/15] ebpf-docs: Fix modulo zero, division by zero,
> overflow, and underflow
> 
> > -----Original Message-----
> > From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> > Sent: Friday, September 30, 2022 2:59 PM
> > To: Dave Thaler <dthaler@microsoft.com>
> > Cc: dthaler1968@googlemail.com; bpf@vger.kernel.org
> > Subject: Re: [PATCH 07/15] ebpf-docs: Fix modulo zero, division by
> > zero, overflow, and underflow
> >
> > On Fri, Sep 30, 2022 at 09:54:17PM +0000, Dave Thaler wrote:
> > > [...]
> > > > > +Also note that the modulo operation often varies by language
> > > > > +when the dividend or divisor are negative, where Python, Ruby, etc.
> > > > > +differ from C, Go, Java, etc. This specification requires that
> > > > > +modulo use truncated division (where -13 % 3 == -1) as
> > > > > +implemented in C, Go,
> > > > > +etc.:
> > > > > +
> > > > > +   a % n = a - n * trunc(a / n)
> > > > > +
> > > >
> > > > Interesting bit of info, but I'm not sure how it relates to the ISA doc.
> > >
> > > It's because there's multiple definitions of modulo out there as the
> > > paragraph notes, which differ in what they do with negative numbers.
> > > The ISA defines the modulo operation as being the specific version above.
> > > If you tried to implement the ISA in say Python and didn't know
> > > that, you'd have a non-compliant implementation.
> >
> > Is it because the languages have weird rules to pick between signed vs
> > unsigned mod?
> > At least from llvm pov the smod and umod have fixed behavior.
> 
> It's because there's different mathematical definitions and different languages
> have chosen different definitions.  E.g., languages/libraries that follow Knuth
> use a different mathematical definition than C uses.  For details see:
> 
> https://en.wikipedia.org/wiki/Modulo_operation#Variants_of_the_definition
> 
> https://torstencurdt.com/tech/posts/modulo-of-negative-numbers/
> 
> Dave

Perhaps text like the proposed snippet quoted in the exchange above should be
added around the new text that now appears in the doc, i.e. the ambiguous text
is currently:
> For signed operations (``BPF_SDIV`` and ``BPF_SMOD``), for ``BPF_ALU``,
> 'imm' is interpreted as a 32-bit signed value. For ``BPF_ALU64``, 'imm'
> is first :term:`sign extended<Sign Extend>` from 32 to 64 bits, and then
> interpreted as a 64-bit signed value.  

Dave

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

