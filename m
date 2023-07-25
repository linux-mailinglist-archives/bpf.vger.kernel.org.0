Return-Path: <bpf+bounces-5830-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20EDD761AD6
	for <lists+bpf@lfdr.de>; Tue, 25 Jul 2023 16:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 433D41C20ED1
	for <lists+bpf@lfdr.de>; Tue, 25 Jul 2023 14:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A948200C4;
	Tue, 25 Jul 2023 14:00:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB951F174
	for <bpf@vger.kernel.org>; Tue, 25 Jul 2023 14:00:25 +0000 (UTC)
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7701FB0
	for <bpf@vger.kernel.org>; Tue, 25 Jul 2023 07:00:24 -0700 (PDT)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 3302DC152575
	for <bpf@vger.kernel.org>; Tue, 25 Jul 2023 07:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1690293624; bh=huPcl1LMr4xs55p9HMFDwLk4LDMC75H1+ntaLpLF8nk=;
	h=To:Date:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=tlOn1NJtQ3byyVLBsJnzyHNAvPD/jenuIKjzeA1zFZol8PaKxEohuPi1WOoIJUoBK
	 ZFo1p/bRFkg5x7UmKf3GX9z4smUyUNxT1Xcs9xXpNF6LFR8kHSvug4vUoD390AU49t
	 qG0lJlK1+7k7jXJwSz7SBiBi5sNUQ13xQc+Oo/fg=
Received: from ietfa.amsl.com (localhost [IPv6:::1])
 by ietfa.amsl.com (Postfix) with ESMTP id 06B38C15199F;
 Tue, 25 Jul 2023 07:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
 t=1690293624; bh=huPcl1LMr4xs55p9HMFDwLk4LDMC75H1+ntaLpLF8nk=;
 h=From:To:Date:References:In-Reply-To:Subject:List-Id:
 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
 b=R8ukUoSGhq2dWnblRzLMgMmQO14+hmaI7bR+ugA00oF+2GzMI0wRZyBd3PTkmVoXq
 RnPlgZKPYlOp+NWjgSBzCgFufCCV6TBCFCsFz28xgePgsw8pmxTVdwVlQGYuSGk5a2
 4IaxO6BQE56gIPz0PgRj5nq2KhuWcjUsPYT2BksM=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 29C42C15199B
 for <bpf@ietfa.amsl.com>; Tue, 25 Jul 2023 07:00:22 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Score: -2.1
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HTML_MESSAGE,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (1024-bit key)
 header.d=microsoft.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3Lk419CvARfW for <bpf@ietfa.amsl.com>;
 Tue, 25 Jul 2023 07:00:21 -0700 (PDT)
Received: from BN3PR00CU001.outbound.protection.outlook.com
 (mail-eastus2azon11020025.outbound.protection.outlook.com [52.101.56.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 6266BC15199C
 for <bpf@ietf.org>; Tue, 25 Jul 2023 07:00:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FZaSQMtdQUFQYDPX1Q0fmUVQGdUhXfY9jeSBu0xb+RAdNN/TIoLRVr81dL6+A2s4phdsEnDDZfXvxcWTn1eQZ5s3gNvf/03KnYHK6W1dThGtR/MU+nSg2SuVRoRj5yZoXEq0s+EcvdJez4LtXMQO5zlSi7in34YESyUT0NBY77QS/Y25SaNv5Yui4lWXcxjHjnZX9HF+Rrr5Bt+N7/ufa2LSqsGAfZ/AGc9L7/hFCgrRQ0xdJvdM9TzTm6u6h7S2jfrl2kzBww9whJ13xut3B5ERHuaOhGCUq2xR1DwBfHnb/HOd+ifmacISvKbtybdVA3bD9fpdRYi5DHIM1UIZDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZnvLXqnroGA1hxPEtou9lL1NIWjzVng03BeqNky3Q1k=;
 b=ENsH8EEIpC3NAxuF+VxMztAhvB791Z+EqQGe5Ho/pEJwi+ka0j1NO1rASQE5JyDnYoxDuyUTWTHry+LCNzu1/wbFcyfyAPCMFYIpbSfpEljl5P7yWsV02mh07tikiyJlFzwbM4JisWsEj3Bp7pnRj5B/IPeBubI5ck75pDvy5lJCtc6BFCVWYoXOGKF142WG+92Fe9x2QJMSO7ryCc70g/SUNCIrar2ntcCn+ASH8XK1kalt/r22nEUwg9PlvWtTi0Qd2f6UQUKcI5NjlKNUukptCV7QpD977R/izq375Il5lQZ2cUrJYsiz4oH79jCnmArslRO2nBGnDCgIh+LQPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZnvLXqnroGA1hxPEtou9lL1NIWjzVng03BeqNky3Q1k=;
 b=VROkNn4rVOUCVMYVSmEc7p/0asNy4XLi100uIdW3KHOr5JwyI+81lNoWxO3BZUPEz5Ho5Ekkw6zeend6G/d49n34lnO7TuspCGzbVZbQpHZiB9R5k+5UMCGH2SPimAHTGbLsPQXGNoLO6q3NiABhApiU5PofkC5qqZwWstSq16A=
Received: from PH7PR21MB3878.namprd21.prod.outlook.com (2603:10b6:510:243::22)
 by MN0PR21MB3217.namprd21.prod.outlook.com (2603:10b6:208:37a::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.5; Tue, 25 Jul
 2023 14:00:18 +0000
Received: from PH7PR21MB3878.namprd21.prod.outlook.com
 ([fe80::3cfe:3743:361a:d95b]) by PH7PR21MB3878.namprd21.prod.outlook.com
 ([fe80::3cfe:3743:361a:d95b%3]) with mapi id 15.20.6652.002; Tue, 25 Jul 2023
 14:00:18 +0000
To: Watson Ladd <watsonbladd@gmail.com>, "bpf@ietf.org" <bpf@ietf.org>, bpf
 <bpf@vger.kernel.org>
Thread-Topic: [Bpf] Review of draft-thaler-bpf-isa-01
Thread-Index: AQHZvrWW9Z2mpBtp0E2+6M55X5/AaK/KgvVw
Date: Tue, 25 Jul 2023 14:00:17 +0000
Message-ID: <PH7PR21MB387892F94D82AA2845845382A303A@PH7PR21MB3878.namprd21.prod.outlook.com>
References: <CACsn0ckZO+b5bRgMZhOvx+Jn-sa0g8cBD+ug1CJEdtYxSm_hgA@mail.gmail.com>
In-Reply-To: <CACsn0ckZO+b5bRgMZhOvx+Jn-sa0g8cBD+ug1CJEdtYxSm_hgA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=4a311dce-492a-41c5-909c-e600815bbf63;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-07-25T13:59:11Z; 
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR21MB3878:EE_|MN0PR21MB3217:EE_
x-ms-office365-filtering-correlation-id: 95875576-e7b9-4c80-1b1c-08db8d177a58
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MB+s/oxxcIfhufX/W5NHWXOsX0fLuZ80FSAnA13TPD2Lm3/rqeWpifSKcUMWffbBqpfK0lMskl9Zu4sQWx7CY8RZJXvZeRML2V5bDh29oHH4qWlddunbGOsLkadTWTZrNHh63Tkst79ZWO+hzBC7knUynSR4t6y/dZbLuyZNUWuqLLQ9cM/cyqi/Hh/UID4COh2tyqNYLh/YcvKHHq7xcNqneQPQb8Z3ne1Z36o9VvKM1NoGavLkx7iVbJjOOGHwkYTbWA5burs6+WxSf6mSwCBjU74zMZxM729QZT3SL++guMo8PuvXNl2r+QhTmEiV97hirip1EZnWBZbuhDJIbRZ9Rryid+f7TbT3s4rMtwPJF/ZL4sevthTrwVyx12LzvyqMivDVSVYsA6CpUzVaIGAF+eMYm/2TVG1bSlI2/helVCFQWTrv+kCRe9Wp+RjwknvPJnGbrXUZJZ72YQbIUESFvNky+jJ6wTqljsDiPJMewgdI7QRWAvSDL6iw/Ommz3y8jT7Udxz6RTkP5jJmTxo57fGKb9lC27dt7za5HrbbGcXEork9IYreMPhSMGlmO+B8/IMOtieSX6/2oV/jZ//afyhKqztRwwPSkNB2raPnuNzEQAMvr4OD6hCrw6p9++VODl95XoPBBdPHFQrDUkmHVEAplm5dD+DoA50gT28=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:; 
 IPV:NLI; SFV:NSPM;
 H:PH7PR21MB3878.namprd21.prod.outlook.com; PTR:; CAT:NONE; 
 SFS:(13230028)(4636009)(396003)(366004)(39860400002)(136003)(346002)(376002)(451199021)(8990500004)(55016003)(52536014)(5660300002)(4744005)(2906002)(478600001)(10290500003)(110136005)(7696005)(71200400001)(316002)(8676002)(41300700001)(8936002)(66946007)(66446008)(64756008)(66556008)(66476007)(76116006)(33656002)(83380400001)(86362001)(38100700002)(122000001)(82950400001)(82960400001)(38070700005)(9686003)(186003)(6506007)(53546011);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bTU5WHlDb0c2TWhLMjE1bER1MnNWS2R1QVVwV3gzVy9QdWtwNWFDZk1mK3hz?=
 =?utf-8?B?dlJ2azluOWJtaElBRlcrVjFEU05EOUJjaG9LTEh4ZkRsTWRJTmlkMW1CVk9m?=
 =?utf-8?B?Mml2SnpKajg0elZCNFBFczJuV0JXeGlFZ1hRNS9GUFdKN05yazhEVjNCYVRq?=
 =?utf-8?B?WE9CQ2xvK1p0MGNuNk5WbURTVlpONDFQMG1iNVZNZEsxbVU1MlVIdXBOYUpQ?=
 =?utf-8?B?Ky9zTEs4THd1a2dtUVhTa20zRlVTWXRNQTNJZU1qQkF2S3krOVhEdUdKc3Nh?=
 =?utf-8?B?RjRUOVA5K1B2MHFiRE52WXZ3UG9PZWJCN01VM3paNDhvQmFlVGpEQ2hEMkJ6?=
 =?utf-8?B?NVl5YmNjK3U5dU1BTlV2eXI0MllteldzNmVwZE5KdGxRcHFqQjdMTlhWc0FK?=
 =?utf-8?B?WHVSa09rOFpNTWJ6RzJ1UGhEUTNWVHlqTHVOZXEzT0dLcStUYVlFZUdVczg0?=
 =?utf-8?B?aDRoRklVRTRad2FobUhLa3Jad1JFS0xwT003UlJvTlpaalY5S010V3hma1M2?=
 =?utf-8?B?RHg0WFFZdk9reHBlakxZeU83UzNFeHhDQVN5bHBuWTY5bTlRa1NHY1VPRjk2?=
 =?utf-8?B?VWZBN2xEb2o1c2JkWHJxY1lMem1iKzN2ZUovYkR3Q2JXTTZsd3VxZDcrYWdh?=
 =?utf-8?B?NDdTNXVrd2x4bFZ0VnlmTnBSZldVNCtpdkJwWnM0c0N5MFpyMjZodFd5Qkxa?=
 =?utf-8?B?NG1PN1V0VFN2cXdoSGV1UW1ySC80eGFtMEt4NjFaQ1ZlZXFza3pOcm5PNGFE?=
 =?utf-8?B?MXpsSGpHa3NGTnQzK0hKVFVyWDY0Vyt5WDQrOWE5Y2YyWStFbjJlMFFUMUVB?=
 =?utf-8?B?eDdOS3I2K1FxT1hrNE4xczV5YmtPRG1URVFVbmErU2QvMnh2QWswNWJTNUIx?=
 =?utf-8?B?NXhBdjM1dU5qZlMyL0JQWHJ3QURDeWhicXhEeHZrQnd1aTFkdEJVU1I2RC9T?=
 =?utf-8?B?czk0Z3M3NVlseTdvdHdDY1RrL0l1U2RnZDJHd2U0Zm9NbXRXMmtaOU9hVlcr?=
 =?utf-8?B?Y3VrWTVZTG9VUmRodWh5WXQxYm1VK2VTbFZpRFVZcVVLd0VVbklQc0lwT3FO?=
 =?utf-8?B?N3VqMXpFQ0RHdUFDOUQrQ3JVT25HMHFhSExXcHl1ZC9MV2h6OHEvOEFRWUJn?=
 =?utf-8?B?MU9RbkxaWmlsNnRlbG94dmQ5M1p4L0VMeXNrTmtJUU1IZEY0RjVJdFVPK3RW?=
 =?utf-8?B?WGhCQWtaQXpiN2p5YXhSeDExdFZxVDJacWIrR1BkLzVHSTVWTHZyRVFIRjdE?=
 =?utf-8?B?RkFQQ1hBVy9wNU0zdmF2Mms4YW53Y1FVMnA3VUs5MndiV3YrQUpxakZNRnlE?=
 =?utf-8?B?aHJxdGlqeThETkhKWmRnZHM5TzNjY3pQbWQ1Sm9lWW9pVnNjZktZeTZMM2cx?=
 =?utf-8?B?azVCaEFvV1lUaGRtWG1QTFNRUUhsdUVOZ0F5VitQai9jalMvcU9raHBxZHdP?=
 =?utf-8?B?aU9CeVRvV3hENTZkb2lpNGI0YUlXdk5KRjJBaWJ2MnhEQWdMa0FnaFZmdkNo?=
 =?utf-8?B?K0VkaFAwQytnK3ZRQlVMeXhPNHdNaDhqNXFoaHA4SUJoYmRoakVBTUI3RTBl?=
 =?utf-8?B?elEwdkJDTWM0eisrcWoycXFYb1lzenZ5TCtSbk9VaFFGeHZwYzVWVlRPMWFD?=
 =?utf-8?B?aUFTbERjYnkvMHNYUGVHdTA2RWdlcVNOYUs2cEl0YlJrZ2M2enNuelBXZHhh?=
 =?utf-8?B?ejlqaWVlMzExRlRsWitDQUdsMUhvQWdSMmp2RDRhZU0zSCtMWDA3cDFLODRJ?=
 =?utf-8?B?OURDTXpVOCtXV2Z5V2dzN1NicGxjV3E3eTJlZU9BWnJQd2hDb2psVUg5Q0Nl?=
 =?utf-8?B?WW9WZzhGei9hTTM2S3RQVE96SUY2SWVhdUwyTHVEdGxzNFBZWXJYK0lYSHhS?=
 =?utf-8?B?aXRlYWdiT2NQRjFRN21wb1FuamZzOGJpdmJ1UVQ3YWhJNXh1WjhRUGpNMUNq?=
 =?utf-8?B?SW4ydFJSWE5DbEd5NGtidU5oWFgzMEhmb2k3SndFSXRPTVNXdkVzYTNlZW5V?=
 =?utf-8?B?TjZaekgvTlhtdUNBOEx2bHplUUNSelZHcXBza3Bmc2EvcFg0TVU5TjhwYzVo?=
 =?utf-8?B?MUQwQzJpR0cvdEhCVWVtLy9ZOU9jZFZIUE1UdVk3RCtHQkVOSCtUNDZ2Wkd6?=
 =?utf-8?B?a05BNlBzZW1GaUN4eW1XZkE5THFyRnR6Z3R5RkJDWFhUV2VZdEh2OHNoWW54?=
 =?utf-8?B?RkpGaW5ZQVdsUWczK0FENm5kNDNyczc3WkJydmg1M1pLR0VWTFBGTlNwRE9M?=
 =?utf-8?B?VjBGVllPbk1hQ1FSalJrUFV4b0lBPT0=?=
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR21MB3878.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95875576-e7b9-4c80-1b1c-08db8d177a58
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2023 14:00:17.8881 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U6dlb7iRqgIGfhSvYS5QpDNzWvELDxRpM5cF2c0qgo15CxktnNKegmAewHrU4siyqt8nEA76WGYFxQbYawrJCkEuSVNgkb3xJPXJUu/xcm4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR21MB3217
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/ScInXaxk-ZSwI99bGshMdjWvNC0>
Subject: Re: [Bpf] Review of draft-thaler-bpf-isa-01
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
Content-Type: multipart/mixed; boundary="===============1528026151538112770=="
Errors-To: bpf-bounces@ietf.org
Sender: "Bpf" <bpf-bounces@ietf.org>
X-Original-From: Dave Thaler <dthaler@microsoft.com>
From: Dave Thaler <dthaler=40microsoft.com@dmarc.ietf.org>
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

--===============1528026151538112770==
Content-Language: en-US
Content-Type: multipart/alternative;
 boundary="_000_PH7PR21MB387892F94D82AA2845845382A303APH7PR21MB3878namp_"

--_000_PH7PR21MB387892F94D82AA2845845382A303APH7PR21MB3878namp_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SSBhbSBmb3J3YXJkaW5nIHRoZSBlbWFpbCBiZWxvdyB0byB0aGUgYnBmQHZnZXIua2VybmVsLm9y
ZzxtYWlsdG86YnBmQHZnZXIua2VybmVsLm9yZz4gbGlzdA0Kc28gcmVwbGllcyBjYW4gZ28gdG8g
Ym90aCBsaXN0cy4NCg0KVGhhbmtzLA0KRGF2ZQ0KRnJvbTogQnBmIDxicGYtYm91bmNlc0BpZXRm
Lm9yZz4gT24gQmVoYWxmIE9mIFdhdHNvbiBMYWRkDQpTZW50OiBNb25kYXksIEp1bHkgMjQsIDIw
MjMgMTA6MDUgUE0NClRvOiBicGZAaWV0Zi5vcmcNClN1YmplY3Q6IFtCcGZdIFJldmlldyBvZiBk
cmFmdC10aGFsZXItYnBmLWlzYS0wMQ0KDQpEZWFyIEJQRiB3ZywNCg0KSSB0b29rIGEgbG9vayBh
dCB0aGUgZHJhZnQgYW5kIHRoaW5rIGl0IGhhcyBzb21lIGlzc3VlcywgdW5zdXJwcmlzaW5nbHkg
YXQgdGhpcyBzdGFnZS4gT25lIGlzIHRoZSBzcGVjaWZpY2F0aW9uIHNlZW1zIHRvIHVzZSBhbiB1
bmRlcnNwZWNpZmllZCBDIHBzZXVkbyBjb2RlIGZvciBvcGVyYXRpb25zIHZzIGRlZmluaW5nIHRo
ZW0gbWF0aGVtYXRpY2FsbHkuDQoNClRoZSBnb29kIG5ld3MgaXMgSSB0aGluayB0aGlzIGlzIHZl
cnkgZml4YWJsZSBhbHRob3VnaCB0ZWRpb3VzLg0KDQpUaGUgb3RoZXIgdGhvcm5pZXIgaXNzdWVz
IGFyZSBtZW1vcnkgbW9kZWwgZXRjLiBCdXQgdGhlIG92ZXJhbGwgc3RydWN0dXJlIHNlZW1zIGdv
b2QgYW5kIHRoZSBkb2N1bWVudCBvdmVyYWxsIG1ha2VzIHNlbnNlLg0KDQpTaW5jZXJlbHksDQpX
YXRzb24gTGFkZA0K

--_000_PH7PR21MB387892F94D82AA2845845382A303APH7PR21MB3878namp_
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: base64

PGh0bWwgeG1sbnM6dj0idXJuOnNjaGVtYXMtbWljcm9zb2Z0LWNvbTp2bWwiIHhtbG5zOm89InVy
bjpzY2hlbWFzLW1pY3Jvc29mdC1jb206b2ZmaWNlOm9mZmljZSIgeG1sbnM6dz0idXJuOnNjaGVt
YXMtbWljcm9zb2Z0LWNvbTpvZmZpY2U6d29yZCIgeG1sbnM6bT0iaHR0cDovL3NjaGVtYXMubWlj
cm9zb2Z0LmNvbS9vZmZpY2UvMjAwNC8xMi9vbW1sIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcv
VFIvUkVDLWh0bWw0MCI+DQo8aGVhZD4NCjxtZXRhIGh0dHAtZXF1aXY9IkNvbnRlbnQtVHlwZSIg
Y29udGVudD0idGV4dC9odG1sOyBjaGFyc2V0PXV0Zi04Ij4NCjxtZXRhIG5hbWU9IkdlbmVyYXRv
ciIgY29udGVudD0iTWljcm9zb2Z0IFdvcmQgMTUgKGZpbHRlcmVkIG1lZGl1bSkiPg0KPHN0eWxl
PjwhLS0NCi8qIEZvbnQgRGVmaW5pdGlvbnMgKi8NCkBmb250LWZhY2UNCgl7Zm9udC1mYW1pbHk6
IkNhbWJyaWEgTWF0aCI7DQoJcGFub3NlLTE6MiA0IDUgMyA1IDQgNiAzIDIgNDt9DQpAZm9udC1m
YWNlDQoJe2ZvbnQtZmFtaWx5OkNhbGlicmk7DQoJcGFub3NlLTE6MiAxNSA1IDIgMiAyIDQgMyAy
IDQ7fQ0KQGZvbnQtZmFjZQ0KCXtmb250LWZhbWlseTpBcHRvczt9DQovKiBTdHlsZSBEZWZpbml0
aW9ucyAqLw0KcC5Nc29Ob3JtYWwsIGxpLk1zb05vcm1hbCwgZGl2Lk1zb05vcm1hbA0KCXttYXJn
aW46MGluOw0KCWZvbnQtc2l6ZToxMS4wcHQ7DQoJZm9udC1mYW1pbHk6IkNhbGlicmkiLHNhbnMt
c2VyaWY7fQ0KYTpsaW5rLCBzcGFuLk1zb0h5cGVybGluaw0KCXttc28tc3R5bGUtcHJpb3JpdHk6
OTk7DQoJY29sb3I6IzQ2Nzg4NjsNCgl0ZXh0LWRlY29yYXRpb246dW5kZXJsaW5lO30NCnNwYW4u
RW1haWxTdHlsZTE4DQoJe21zby1zdHlsZS10eXBlOnBlcnNvbmFsLXJlcGx5Ow0KCWZvbnQtZmFt
aWx5OiJBcHRvcyIsc2Fucy1zZXJpZjsNCgljb2xvcjp3aW5kb3d0ZXh0O30NCi5Nc29DaHBEZWZh
dWx0DQoJe21zby1zdHlsZS10eXBlOmV4cG9ydC1vbmx5Ow0KCWZvbnQtZmFtaWx5OiJBcHRvcyIs
c2Fucy1zZXJpZjsNCgltc28tbGlnYXR1cmVzOm5vbmU7fQ0KQHBhZ2UgV29yZFNlY3Rpb24xDQoJ
e3NpemU6OC41aW4gMTEuMGluOw0KCW1hcmdpbjoxLjBpbiAxLjBpbiAxLjBpbiAxLjBpbjt9DQpk
aXYuV29yZFNlY3Rpb24xDQoJe3BhZ2U6V29yZFNlY3Rpb24xO30NCi0tPjwvc3R5bGU+PCEtLVtp
ZiBndGUgbXNvIDldPjx4bWw+DQo8bzpzaGFwZWRlZmF1bHRzIHY6ZXh0PSJlZGl0IiBzcGlkbWF4
PSIxMDI2IiAvPg0KPC94bWw+PCFbZW5kaWZdLS0+PCEtLVtpZiBndGUgbXNvIDldPjx4bWw+DQo8
bzpzaGFwZWxheW91dCB2OmV4dD0iZWRpdCI+DQo8bzppZG1hcCB2OmV4dD0iZWRpdCIgZGF0YT0i
MSIgLz4NCjwvbzpzaGFwZWxheW91dD48L3htbD48IVtlbmRpZl0tLT4NCjwvaGVhZD4NCjxib2R5
IGxhbmc9IkVOLVVTIiBsaW5rPSIjNDY3ODg2IiB2bGluaz0iIzk2NjA3RCIgc3R5bGU9IndvcmQt
d3JhcDpicmVhay13b3JkIj4NCjxkaXYgY2xhc3M9IldvcmRTZWN0aW9uMSI+DQo8cCBjbGFzcz0i
TXNvTm9ybWFsIj48c3BhbiBzdHlsZT0iZm9udC1mYW1pbHk6JnF1b3Q7QXB0b3MmcXVvdDssc2Fu
cy1zZXJpZiI+SSBhbSBmb3J3YXJkaW5nIHRoZSBlbWFpbCBiZWxvdyB0byB0aGUNCjxhIGhyZWY9
Im1haWx0bzpicGZAdmdlci5rZXJuZWwub3JnIj5icGZAdmdlci5rZXJuZWwub3JnPC9hPiBsaXN0
PGJyPg0Kc28gcmVwbGllcyBjYW4gZ28gdG8gYm90aCBsaXN0cy48bzpwPjwvbzpwPjwvc3Bhbj48
L3A+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj48c3BhbiBzdHlsZT0iZm9udC1mYW1pbHk6JnF1b3Q7
QXB0b3MmcXVvdDssc2Fucy1zZXJpZiI+PG86cD4mbmJzcDs8L286cD48L3NwYW4+PC9wPg0KPHAg
Y2xhc3M9Ik1zb05vcm1hbCI+PHNwYW4gc3R5bGU9ImZvbnQtZmFtaWx5OiZxdW90O0FwdG9zJnF1
b3Q7LHNhbnMtc2VyaWYiPlRoYW5rcyw8bzpwPjwvbzpwPjwvc3Bhbj48L3A+DQo8cCBjbGFzcz0i
TXNvTm9ybWFsIj48c3BhbiBzdHlsZT0iZm9udC1mYW1pbHk6JnF1b3Q7QXB0b3MmcXVvdDssc2Fu
cy1zZXJpZiI+RGF2ZTwvc3Bhbj48YnI+DQo8c3BhbiBzdHlsZT0iZm9udC1mYW1pbHk6JnF1b3Q7
QXB0b3MmcXVvdDssc2Fucy1zZXJpZiI+PG86cD48L286cD48L3NwYW4+PC9wPg0KPGRpdiBzdHls
ZT0iYm9yZGVyOm5vbmU7Ym9yZGVyLWxlZnQ6c29saWQgYmx1ZSAxLjVwdDtwYWRkaW5nOjBpbiAw
aW4gMGluIDQuMHB0Ij4NCjxkaXY+DQo8ZGl2IHN0eWxlPSJib3JkZXI6bm9uZTtib3JkZXItdG9w
OnNvbGlkICNFMUUxRTEgMS4wcHQ7cGFkZGluZzozLjBwdCAwaW4gMGluIDBpbiI+DQo8cCBjbGFz
cz0iTXNvTm9ybWFsIj48Yj5Gcm9tOjwvYj4gQnBmICZsdDticGYtYm91bmNlc0BpZXRmLm9yZyZn
dDsgPGI+T24gQmVoYWxmIE9mIDwvYj4NCldhdHNvbiBMYWRkPGJyPg0KPGI+U2VudDo8L2I+IE1v
bmRheSwgSnVseSAyNCwgMjAyMyAxMDowNSBQTTxicj4NCjxiPlRvOjwvYj4gYnBmQGlldGYub3Jn
PGJyPg0KPGI+U3ViamVjdDo8L2I+IFtCcGZdIFJldmlldyBvZiBkcmFmdC10aGFsZXItYnBmLWlz
YS0wMTxvOnA+PC9vOnA+PC9wPg0KPC9kaXY+DQo8L2Rpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwi
PjxvOnA+Jm5ic3A7PC9vOnA+PC9wPg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPkRlYXIg
QlBGIHdnLDxvOnA+PC9vOnA+PC9wPg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPjxvOnA+
Jm5ic3A7PC9vOnA+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+SSB0
b29rIGEgbG9vayBhdCB0aGUgZHJhZnQgYW5kIHRoaW5rIGl0IGhhcyBzb21lIGlzc3VlcywgdW5z
dXJwcmlzaW5nbHkgYXQgdGhpcyBzdGFnZS4gT25lIGlzIHRoZSBzcGVjaWZpY2F0aW9uIHNlZW1z
IHRvIHVzZSBhbiB1bmRlcnNwZWNpZmllZCBDIHBzZXVkbyBjb2RlIGZvciBvcGVyYXRpb25zIHZz
IGRlZmluaW5nIHRoZW0gbWF0aGVtYXRpY2FsbHkuPG86cD48L286cD48L3A+DQo8L2Rpdj4NCjxk
aXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj48bzpwPiZuYnNwOzwvbzpwPjwvcD4NCjwvZGl2Pg0K
PGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPlRoZSBnb29kIG5ld3MgaXMgSSB0aGluayB0aGlz
IGlzIHZlcnkgZml4YWJsZSBhbHRob3VnaCB0ZWRpb3VzLjxvOnA+PC9vOnA+PC9wPg0KPC9kaXY+
DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+PG86cD4mbmJzcDs8L286cD48L3A+DQo8L2Rp
dj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj5UaGUgb3RoZXIgdGhvcm5pZXIgaXNzdWVz
IGFyZSBtZW1vcnkgbW9kZWwgZXRjLiBCdXQgdGhlIG92ZXJhbGwgc3RydWN0dXJlIHNlZW1zIGdv
b2QgYW5kIHRoZSBkb2N1bWVudCBvdmVyYWxsIG1ha2VzIHNlbnNlLjxvOnA+PC9vOnA+PC9wPg0K
PC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+PG86cD4mbmJzcDs8L286cD48L3A+
DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj5TaW5jZXJlbHksPG86cD48L286
cD48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj5XYXRzb24gTGFkZDxv
OnA+PC9vOnA+PC9wPg0KPC9kaXY+DQo8L2Rpdj4NCjwvZGl2Pg0KPC9kaXY+DQo8L2JvZHk+DQo8
L2h0bWw+DQo=

--_000_PH7PR21MB387892F94D82AA2845845382A303APH7PR21MB3878namp_--


--===============1528026151538112770==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

--===============1528026151538112770==--


