Return-Path: <bpf+bounces-816-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1673770709C
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 20:20:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1869281312
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 18:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A50CC31F03;
	Wed, 17 May 2023 18:20:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5438410966
	for <bpf@vger.kernel.org>; Wed, 17 May 2023 18:20:09 +0000 (UTC)
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98263D053
	for <bpf@vger.kernel.org>; Wed, 17 May 2023 11:20:06 -0700 (PDT)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 40827C1516EB
	for <bpf@vger.kernel.org>; Wed, 17 May 2023 11:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1684347606; bh=UNLgBq+AEw9YjVpKPVGaT+8AvDHu0sKc78+7ObrRVEA=;
	h=To:CC:Date:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lUvde8OJzWhjUNwb9w3sio2fHxSfI1e9nwJe6S99bP6wP/HFtWI5elBkXg6aV5++D
	 8Vt0uyr2oiMQhwfOBF/m3LLeKCp3k++gGIFshSaubc6exzGoi+m9g2b7d6SkuHcd3j
	 mFntfgE9KYNh9OVakWsjahcpsnRJWIxkm+MzAEJc=
Received: from ietfa.amsl.com (localhost [IPv6:::1])
 by ietfa.amsl.com (Postfix) with ESMTP id 1E9DEC151082;
 Wed, 17 May 2023 11:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
 t=1684347606; bh=UNLgBq+AEw9YjVpKPVGaT+8AvDHu0sKc78+7ObrRVEA=;
 h=From:To:CC:Date:References:In-Reply-To:Subject:List-Id:
 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
 b=gzyntCwse30Jhhcl9pcCDVPir56QK484EP7DLZ0mCjjVnqK9PyDf3NwLHl+dDwkAE
 HAqDM1H6VVPpiPMeNA2He9NnwaNNHhDJ2F7T15KyrYK6MkmOvSromOnI6lPNH6y3Tn
 qT5UnfYZ5qjAYozqE400hNoDBoM1whkN13duLS14=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 72400C151074
 for <bpf@ietfa.amsl.com>; Wed, 17 May 2023 11:20:04 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Score: -7.099
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (1024-bit key)
 header.d=microsoft.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id i8-rQcjw84xo for <bpf@ietfa.amsl.com>;
 Wed, 17 May 2023 11:20:01 -0700 (PDT)
Received: from BN6PR00CU002.outbound.protection.outlook.com
 (mail-eastus2azon11021026.outbound.protection.outlook.com [52.101.57.26])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id C1401C151082
 for <bpf@ietf.org>; Wed, 17 May 2023 11:20:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xyd1ruhWekuhtNx9mGAidh3CLn+FRyt1eX6aXQ+qfaJ/TPD79vDVojUII2/ifbxFIO+iBH5RdJSWxUeDSN916+CiYa/lewVIPQLHUR2SrjkxkoOGPxsjeiVIsxT0jn4OHxnJ2UA0/zLcJ5V+m/0HD6GaeK+WGkSv5AVacjRry9H3L1rpC0sgFFuebCiqkT7OFsaACNqNb5BvZgYSpmxFOedxqY6CM6sv5G1fmjeWKhX1uO70GxTQzvH0TYqtiqwiu3lITDiq3EkoU49vN7kMwFuld+XLIaK/k9qdQQ4GYgcIiEGDR+tK4XQedPZk1QHTj+N70hM0SM7H8B++0av1CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H3tVUJMthccBIK4FF+nxmOCfJP7Jr5v2zVrgKHKadLI=;
 b=dCfGSnUSsDjMx7Nr5du261x2I5YiqcVKF5mHSwtiAR5u655ahxZXq8ZFqJ2oDkTPDrlqjPpB4lta/t8Xps5I+gJEWIwbft8IkZOR043XSWqvT0tIUAz6o2TQvHK4RcjHW0D1sqOPWWx2CHm2yoHB7wISUpP6u8d18R9wEHyxStajZwBzEILccuHLuBy3ymj1GU8qTsDafn7Rv4+cLvjPxyrVXW3k1XCBV5UjQicCB02a15U8DwipQpWh1qhIPhcUsZKZyrJx8r+cBTNP23GwoTFbpOyW9EeRYZsdTI0bCSZPn+YE2dV/pGajfcENcDwfLosRMWphK4l58U4cbAKHuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H3tVUJMthccBIK4FF+nxmOCfJP7Jr5v2zVrgKHKadLI=;
 b=ChJxu096xb8tPSyr9RBnytcsPzhVFAAlsEQ3+DAlQjr4tSDFLFyg8a+V9v0Za8KHRkS1yyNiozbSfSFcGxi1hUt3v1IrAKG5/LxRvq+d6OyGmFHEiganyfvc3H1yIZv1BTHstj9t5lknjaQbrtr30ENNFZCqFdcDBXSG0jl2WCI=
Received: from PH7PR21MB3878.namprd21.prod.outlook.com (2603:10b6:510:243::22)
 by MWH0PFED0FAB2BB.namprd21.prod.outlook.com
 (2603:10b6:30f:fff1:0:1:0:15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.6; Wed, 17 May
 2023 18:19:42 +0000
Received: from PH7PR21MB3878.namprd21.prod.outlook.com
 ([fe80::ebee:52ea:94c9:4e43]) by PH7PR21MB3878.namprd21.prod.outlook.com
 ([fe80::ebee:52ea:94c9:4e43%7]) with mapi id 15.20.6433.000; Wed, 17 May 2023
 18:19:42 +0000
To: "Jose E. Marchesi" <jemarch@gnu.org>, Dave Thaler
 <dthaler=40microsoft.com@dmarc.ietf.org>
CC: "bpf@ietf.org" <bpf@ietf.org>, bpf <bpf@vger.kernel.org>
Thread-Topic: [Bpf] IETF BPF working group draft charter
Thread-Index: AdmIWSmp8uIYgrASRIKQXfLbLZQgdgAeO2knAAYWUOA=
Date: Wed, 17 May 2023 18:19:42 +0000
Message-ID: <PH7PR21MB3878BCFA99C1585203982670A37E9@PH7PR21MB3878.namprd21.prod.outlook.com>
References: <PH7PR21MB38780769D482CC5F83768D3CA37E9@PH7PR21MB3878.namprd21.prod.outlook.com>
 <87v8grkn67.fsf@gnu.org>
In-Reply-To: <87v8grkn67.fsf@gnu.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=56c6f184-81ad-48e6-9cc2-0f9ceded326e;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-05-17T18:07:27Z; 
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR21MB3878:EE_|MWH0PFED0FAB2BB:EE_
x-ms-office365-filtering-correlation-id: 722724af-1c2d-4f56-50b3-08db57034916
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aTwACfqEt7BWYV0bljjgT/kuZEycbFgLsQdXJGq9YXcN8q2wnhcS55fkVA9FJ3xD/HSdr301aNwBX8LFtDdCckMsK3KSiZ+1Wxf6+v5HAuXktQxvs1nJuFGgzSb769SNoHLq2qgD2KPEDRkmhKAGsXMDSUFZlrsxazOSCS2loc2MlYxRWje5RsWJ7peti5Sv4fsivn5guxw8XvlKBp4QWA+k6ff81nso7oz3qygoa93f3dBf/7I/0PZ7apK6I2iNv6gfYFbw4E8grDEOrqUrdCLBo6nu/38rDKHTw3AwhK4ReEpLZZYvFDUz4LDboYTyOQaod6X105KyUIZPKVMnWp84lPfu+mVNQe3qV8Xsdve/ainiWCWNlOC3FF8FNsLuoqKRZA+DsV7xbb2FeGYSOBf7T0Q5dTBYyJNArUs3sEedJ80akfUDtfY/X0V49mfO4x7k2aT6nQew3OmEy/eoxE21o/ZMhN8gC5KFf0hKHjJGFA1BCML41FPjN7rLF9Im2ti/H2VMKzl2f12kmtWJPWIRwokYa5j/o4x5iDkyLdVwycrWevpm1Y/0U9bQU1WKvqNCwhO1tVQBjvYbww+AsEETnJth5xJzSSsuaGooIfKFQv6KjKNqiuBq/mBRce1NNr94qy4H9xc1igaEDYcsAA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:; 
 IPV:NLI; SFV:NSPM;
 H:PH7PR21MB3878.namprd21.prod.outlook.com; PTR:; CAT:NONE; 
 SFS:(13230028)(4636009)(39860400002)(346002)(136003)(366004)(396003)(376002)(451199021)(66476007)(8990500004)(71200400001)(2906002)(5660300002)(52536014)(41300700001)(4326008)(76116006)(66446008)(66946007)(110136005)(64756008)(66556008)(54906003)(478600001)(786003)(8936002)(8676002)(316002)(10290500003)(83380400001)(38100700002)(33656002)(966005)(7696005)(9686003)(82960400001)(82950400001)(186003)(6506007)(38070700005)(55016003)(122000001)(86362001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mp3X3sisS9fBPL2xx12Ht2ZEuDZCmIHcXu29efpq5sZfKHumEdS61CyCmFnx?=
 =?us-ascii?Q?jsX3OsHN8MaZWCE+8L98Z3l9VU5WCPHE1x49cfXg0kzZTzBdhrPNP2i2yNtI?=
 =?us-ascii?Q?i0nk//tdrlRvGjF9qUcMg1HDutf8lIudwIQt206PnrsMRLt4G/MEH+fNkxdM?=
 =?us-ascii?Q?RXKsu2XDrLI4XkzbynJEb6URdhY3PxxlJR3jZi9lxRofd3DLxbIYXQWLgcOK?=
 =?us-ascii?Q?4LEifD4WGDU/I/o9rg4J9S95IJYFlDxWqvdoSmebyhPdTEqe3W3LBd9xkqzt?=
 =?us-ascii?Q?Y9pIDg9RGTnELp99eIjWPnKEppqJ+mB+Mma8R1qvqyIuaxJzkpfjXVeLkour?=
 =?us-ascii?Q?kZBv25zUBDcvFFHAgYlHjupLjG2TUMLeWDx60Pco1jG0TlexkrLxA4tKpq8S?=
 =?us-ascii?Q?mS8QHSbprPHvLafB0ZBGIbv9yzP9TLqABDsPEV84CmyzjCD/MEepUihowLfO?=
 =?us-ascii?Q?hYAt7Y2tbxMDsoCTuOpEBK+IsELjZfacj58gd9yJ3MJXhQQdffRxNY0sYGdN?=
 =?us-ascii?Q?SntLlUVQrPt/j8B2NmmE3dzy4S4oBo8ucPs1iYSbcMV+rc9xGwPLeMs+huAX?=
 =?us-ascii?Q?njVOcOqo3An0FUqc3KHiLFTksYgC6VFezP/LCyTw/fqmkjdgMNd2urKTcGWE?=
 =?us-ascii?Q?/jF7rzpfl/sTYu6RJhTJnr6mVM/322wKuS3uRsPAeagSCXe4u/p5faXjhLhG?=
 =?us-ascii?Q?Lhzw00XyBYI8c2woUKqbWdZgmVE/rKPtbeB7b3z0zUhaIPfKdufc6kLhOijh?=
 =?us-ascii?Q?tPvlJxAqgnaD7FsABgfrtNo5WutcQ9SJ1uHlvfDSBx1ohUZhjv70FJRK6EQX?=
 =?us-ascii?Q?AZEnC6TWMQv7f+YMbTvDoaufwCpZ9/hsrF+nmb7zo69GbHQ3yeXXWAEkB+Ub?=
 =?us-ascii?Q?thMekIpW0JS2m7XDy9HansXvJikNDKjH0XovF8CpkM5SRSeYgIhJTtPTsqAd?=
 =?us-ascii?Q?1zeiv5F+8ZxqE3jS66ZwFjFkJLqWFVFRpfFTI+5ptzfE/YWhFjJvqnf+rfK6?=
 =?us-ascii?Q?ZabnZ5W6QSuSI69F6AppPHZZDoi0/UCmBBcXk8M8P1wR8wxjAdhSWZuaJ4l8?=
 =?us-ascii?Q?zGrwBBSCAgj22NbdoMAnLWZhr6prQAMDXlcO7+X1VL/fgGME/IMyqp1klOCk?=
 =?us-ascii?Q?4CumnQ2RFrmhNn0hWRecykOcNQFMvVQBgSlEUzLPu8y6L4n+qglBIi8kjbpD?=
 =?us-ascii?Q?TYNGO1hbOmceXQyPhOBNo+byF1+97NumrEC9iG6iji1PII4+soWsXZqIV1Wm?=
 =?us-ascii?Q?ZbKwN/Pvevt+EQfpEU0xeToF8vsBKRhVLkLCWjv1FMrMKyCnI6+R2a4m+BLA?=
 =?us-ascii?Q?HhZL86vYFKi4ZkU6aeQAMtgEzmQJ6FmZjc+f5PTOx8CqnpG/54UKcyP0s44q?=
 =?us-ascii?Q?SBo1X4ZHUIH68WekTvOBPqDHP1EnHE3qVz5R9KWR59liFaoi2zMhhNFffj6C?=
 =?us-ascii?Q?LuSzjJLYaSD+hpnfsR7GP05J0Ug6rs4+p/q/kSe5/TNWL00h8VSH5mvY9FtN?=
 =?us-ascii?Q?IODqm9eVFBd+I56lfdOCoapp0q16MzPszC0AtfauGniTW9jHNyThhP8O/taU?=
 =?us-ascii?Q?Kz1pYzmqC7UiUhaJpza00l1yWnXqNk8Vc/MPT9ej1BkXHv86PgzlNat3YpM8?=
 =?us-ascii?Q?7EkvNbk1hLWg2VIMkEh2E17a8avC9SpM8EVQS7/09RSMXK51r7lx7tMZJqb9?=
 =?us-ascii?Q?MV/f0g=3D=3D?=
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR21MB3878.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 722724af-1c2d-4f56-50b3-08db57034916
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2023 18:19:42.5392 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FVABKFs/EIp7NIdlJyNUQOkuWIxjaXi2XV/8NieRavVT9EKjztEt87/Ct//daGA4BWPfJmVMjVzHqe9HXaXuKwHuG57ugLgTqGfod+fmiCI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWH0PFED0FAB2BB
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/4ysJB-3PV_Fso78Jr1imn-KgjK0>
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

Jose E. Marchesi wrote:
> As I mentioned during your talk at LSF/MM/BPF, I think that two items may be
> a bit confusing, and worth to clarify:
>
>   * the eBPF bindings for the ELF executable file format,
>
> What does "eBPF bindings" mean in this context?  I think there are at least two
> possible interpretations:
>
> 1) The way BPF uses ELF, not impacting internal ELF structures.  For
>    example the special section names that a conformant BPF loader
>    expects and understands, such as ".probes", or rules on how to use
>    the symbols visibility, or how notes are used (if they are used) etc
>
> 2) The ELF extensions that BPF introduces (and may introduce at some
>    point) as an architecture, such as machine number, section types,
>    special section indices, segment types, relocation types, symbol
>    types, symbol bindings, additional section and segment flags, file
>    flags, and perhaps structures of the contents of some special
>    sections.

See https://www.ietf.org/archive/id/draft-thaler-bpf-elf-00.html
It includes the values used in the ELF header, section naming,
use of the "license" and "version" sections, meaning of "maps" and
".maps" sections, etc.

> If the intended meaning of that point in the draft is 1), then I would suggest to
> change the wording to something like:
>
> * the requirements and expectations that ELF files shall fulfill so they
>   can be handled by conformant eBPF implementations.

My own opinion is to leave the more detailed definition of what belongs
in the ELF spec vs another document up to the WG to define rather than
baking it into the charter.

> Otherwise, if the intended meaning in the draft charter is to cover 2), I would
> like to note that, usually and conventionally ELF extensions introduced by
> architectures (and operating systems in the ELF sense)
> are:
>
> - Part of the psABI (chapter Object Files).
>
> - Not standards, in the sense that these are not handled by
>   standardization bodies.
>
> - Maintained by corporations, associations, and/or community groups, and
>   published in one form or another.  A few examples of both arch and os
>   extensions:
>
>   + The x86_64 psABI, including the ELF bits, is maintained by Intel
>     (mainly by HJ Lu, a toolchain hacker) and available in a git repo in
>     gitlab [1].
>
>   + The risc-v psABI, including the ELF bits, is maintained by I believe
>     RISC-V International and the community, and is available in a git
>     repo in github [2].
>
>   + The GNU extensions to the gABI, including the ELF bits, is
>     maintained by GNU hackers and available in a git repo in sourceware
>     [3].
>
>   + The llvm extensions to ELF, which in this case take the form of an
>     "os" in the ELF sense even if it is not an operating system, are
>     maintained by the LLVM project and available in the
>     docs/Extensions.rst file in the llvm source distribution.
>
>   Note that more often than not this is kept quite informally, without
>   the need of much bureocratic overhead.  A git repo in github or the
>   like, maintained by the eBPF foundation or similar, would be more than
>   enough IMO.

To ensure interoperability, I'd want a slightly more formal specification.

> - Open to suggestions and contributions from the community, vendors,
>   implementors, etc.  This usually involves having a mailing list where
>   such suggestions can be sent an discussed.  Almost always very little
>   discussion is required, if any, because the proposed extension has
>   already been agreed and worked on by the involved parties: toolchains,
>   consumers, etc.
>
> - Continuously evolving.
>
> So, would the IETF working group be able to accomodate something like the
> above?  For example, once a document is officially published by the working
> group, how easy is it to modify it and make a new version to incorporate
> something new, like a new relocation type for example?
> (Apologies for my total ignorance of IETF business :/)

There's 3 ways:
1) The IETF can publish an extension spec with additional optional features.
2) The IETF can publish a replacement to the original (not usually desirable)
3) The IETF can define a process for other organizations or vendors to create
their own extensions, and some mechanism for ensuring that two such
extensions don't collide using the same codepoint.  This is what the charter
implies the WG should do.

Dave

> Likewise, of the following item:
>
>   * the platform support ABI, including calling convention, linker
>     requirements, and relocations,
>
> The calling convention and relocations are part of the psABI and usually
> handled like described above.
>
> PS: BPF is obviously not a SysV system, but when it comes to document
>     the ABI, including the ELF bits, I think it would be a good idea to
>     use the same document structure conventionally used by psABI, as
>     Alexei already suggested some time ago.  This would be most familiar
>     to people.
>
> [1]
> https://gitlab/.
> com%2Fx86-psABIs%2Fx86-64-
> ABI&data=05%7C01%7Cdthaler%40microsoft.com%7Cd4f2ef78d9e0475f514d
> 08db56e91312%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C6381
> 99331900533629%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiL
> CJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C2000%7C%7C%7C&sd
> ata=SaprU2J9WsyJ5qhcxIGKO2F06YtO%2Bm1Gpjb2SIOApLA%3D&reserved=0
> [2]
> https://github/
> .com%2Friscv-non-isa%2Friscv-elf-psabi-
> doc%2Freleases%2Fdownload%2Fv1.0%2Friscv-
> abi.pdf&data=05%7C01%7Cdthaler%40microsoft.com%7Cd4f2ef78d9e0475f5
> 14d08db56e91312%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C6
> 38199331900533629%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMD
> AiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C2000%7C%7C%7C
> &sdata=uKqnU93kcu8rZ9Y0gzWdmuHnK9ySPM847%2FDMm6vJNwQ%3D&res
> erved=0
> [3] git://sourceware.org/git/gnu-gabi.git
>
> --
> Bpf mailing list
> Bpf@ietf.org
> https://www.i/
> etf.org%2Fmailman%2Flistinfo%2Fbpf&data=05%7C01%7Cdthaler%40microso
> ft.com%7Cd4f2ef78d9e0475f514d08db56e91312%7C72f988bf86f141af91ab2
> d7cd011db47%7C1%7C0%7C638199331900533629%7CUnknown%7CTWFpb
> GZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6
> Mn0%3D%7C2000%7C%7C%7C&sdata=W9FXcUwb181VQ6ksF2guASQ5FGtTE
> KZuE0Yb8cHR9vI%3D&reserved=0

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

