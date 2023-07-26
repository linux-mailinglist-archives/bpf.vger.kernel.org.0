Return-Path: <bpf+bounces-6013-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B424976420D
	for <lists+bpf@lfdr.de>; Thu, 27 Jul 2023 00:20:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D76051C2142C
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 22:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9056D1AA77;
	Wed, 26 Jul 2023 22:19:46 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E09E198AA
	for <bpf@vger.kernel.org>; Wed, 26 Jul 2023 22:19:46 +0000 (UTC)
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5570F2717
	for <bpf@vger.kernel.org>; Wed, 26 Jul 2023 15:19:44 -0700 (PDT)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 25C0BC151B0D
	for <bpf@vger.kernel.org>; Wed, 26 Jul 2023 15:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1690409984; bh=fcu5KFMtd81SJVrIf7nubUWWs+RDZafUd1cuAR3VyKg=;
	h=To:CC:Date:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IZrvQhbBec6EhAnuWVdTHsGiYxT71zV+SlBUqdC29Zd6K0vfIgd3BoihR0b6yU+hv
	 r8O39JaUiT9cBLvMLcSzlA3B1WBaw3keu3wjPFPP6jz3DFCp/62S/dTxbh/F1szmva
	 D6d281ZwzxwmAH1iyluKCATpOnfOq0Fgs8VEIuD8=
Received: from ietfa.amsl.com (localhost [IPv6:::1])
 by ietfa.amsl.com (Postfix) with ESMTP id 01453C151078;
 Wed, 26 Jul 2023 15:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
 t=1690409984; bh=fcu5KFMtd81SJVrIf7nubUWWs+RDZafUd1cuAR3VyKg=;
 h=From:To:CC:Date:References:In-Reply-To:Subject:List-Id:
 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
 b=vv9d2LEQz4SMR3Qm+X3Q0HZCONWzsFHuNM1b03Q3o8dUmbLk6jew14BAs9u+jqO9w
 xdZOYD/Xfn7tEwUXKRHCfa15FAgpB+rgd9lcjqB0eEKdXgWTiAl3XNoiR5LL/LmRbx
 tZ4N//CxL6guJRvu7D3LGXpLlaxtnZxosfrRpV7w=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id E2935C151078
 for <bpf@ietfa.amsl.com>; Wed, 26 Jul 2023 15:19:42 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Score: -2.112
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (1024-bit key)
 header.d=microsoft.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id u6YPI9G6iTZz for <bpf@ietfa.amsl.com>;
 Wed, 26 Jul 2023 15:19:42 -0700 (PDT)
Received: from BN6PR00CU002.outbound.protection.outlook.com
 (mail-eastus2azon11021018.outbound.protection.outlook.com [52.101.57.18])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 095CEC15106F
 for <bpf@ietf.org>; Wed, 26 Jul 2023 15:19:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IbT/cT8Tmc8nlO0QjywkoJD7RGF/uIcevN4TdsCucmNvnBuCmaA6yk9i6uFfaVN2fd4bTYqh062wZnC4AiMeBTBtz/YMjq9GBjmBtnR5JMu9ZrRMNAoudMWFQrKNewHg72FUGW5u7X7iPD9taa042q8QCHT99CSvWNPJJjcnmHBTcmI+CcBxUB60J4Vgu+dL0Qb83Vd2SfmCulms4KvGVmjun3x7zNQJt33ipLcFpbC4kXO3BUqKHxjUHSptMERWF+3avXrhHRvhTGAdep9JhyteyCcElTk1d6vvQA2Vhs9KxneCWCsn85ZTkZGvOsJvzG3mOV2Sj5R4wY4XW+fOvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4bZP8EWA+SZOryQaYsHmVuGxhOpFQe12pNlcVSaNn3k=;
 b=UylHWlbOlc+2u9smpviTUfzwcxbXm24ERo4sHkmlaPWHD1HFspNyXGAlreCdfTGld2Nj4L/q/UVnU5zOWt8pyHpmZHmor4V45iQdpnvc75f9Sg3NXomOSvz/xZHZR7gAdGNYv5RP5b+xVJuxbZgWbNkLmRY6c0JdFAZbmiytUHakmJaT6IjWkMrfvi1cMykK49iPL2lZRnQW4QqaH4j9Y9F85747ivE+STuWwlFPGFWNpU3OWLEo8qrAw1cClvC5lN+CPDJ7dyRQl2A7dha4iqkZIRl65ob6/0odwN26ZnyVLOZGa4w9JWBtiAH0YTNBtl8Zsfslh8A07cbPhkKEFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4bZP8EWA+SZOryQaYsHmVuGxhOpFQe12pNlcVSaNn3k=;
 b=Up5ePFGliVynqPZ7fLgVT0UHJ4VxNqexzfvee0JWjlMcQ5nINTYI9+Q7cMTAMW/XKCe4IeQ7OAUJq+yXLTmu5UDkpsx/DgaD/idU091L9ifXOgMQgFL7L2OlreRFtXrx9zRON04GQ5BLAzlartqrgp1/sSbDwvpMwPnrDrZJfuo=
Received: from PH7PR21MB3878.namprd21.prod.outlook.com (2603:10b6:510:243::22)
 by CY5PR21MB3540.namprd21.prod.outlook.com (2603:10b6:930:f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.5; Wed, 26 Jul
 2023 22:19:38 +0000
Received: from PH7PR21MB3878.namprd21.prod.outlook.com
 ([fe80::3cfe:3743:361a:d95b]) by PH7PR21MB3878.namprd21.prod.outlook.com
 ([fe80::3cfe:3743:361a:d95b%3]) with mapi id 15.20.6652.002; Wed, 26 Jul 2023
 22:19:37 +0000
To: Yonghong Song <yonghong.song@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, "bpf@vger.kernel.org"
 <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai
 Lau <martin.lau@kernel.org>
CC: David Faust <david.faust@oracle.com>, Fangrui Song <maskray@google.com>,
 "Jose E . Marchesi" <jose.marchesi@oracle.com>, "kernel-team@fb.com"
 <kernel-team@fb.com>, "bpf@ietf.org" <bpf@ietf.org>
Thread-Topic: [PATCH bpf-next v4 17/17] docs/bpf: Add documentation for new
 instructions
Thread-Index: AQHZwA3jclGVVVIlpEu7gNrd9Ot5u6/Mnf1g
Date: Wed, 26 Jul 2023 22:19:37 +0000
Message-ID: <PH7PR21MB3878B7EB62B64CCDA2285543A300A@PH7PR21MB3878.namprd21.prod.outlook.com>
References: <20230726220726.1089817-1-yonghong.song@linux.dev>
 <20230726220858.1104873-1-yonghong.song@linux.dev>
In-Reply-To: <20230726220858.1104873-1-yonghong.song@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=18fea875-3849-46fc-a7b7-57bbdafd5e6f;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-07-26T22:18:05Z; 
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR21MB3878:EE_|CY5PR21MB3540:EE_
x-ms-office365-filtering-correlation-id: 566dc28a-7d39-41fd-993f-08db8e26664d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yWy0AnlX1BLCzPtRqe3X2rv4NXupjwdDvchNq2wVFvA+U3ikcqTRXh0fCj+F61zV1nbEYwdIkDbPmzI17DioVZCUcjNoNrrFOJ0Qd75t75093e7Hxq0sG70gYEJDCpD0ULbnEqQ29YYMc0eARnpxj/CGtOXKiIAenvPQ2T0SqhipCsKsfkf5ZSzI3U2erKWpQa7A0j/8h+p3A6Hsb4epT2vrXaalD/OLa9d8xkH7LiqHhNDx6g9E5bbJhgihsVCrsYqUc90BEWa40XAz6VSwRciqZX811U1MNZGvnHcgWWE/wT+Q1rAQ1TUnb8XZiDA4PDHpmUZ64JSrRRspGW5ysEZHyxHP8W3+QfnvzXllNTo5aPeMfS1jYyIWXCyZvfeAcANXHhnpHbxZQ4teA34Tfpe5foPwM1cbcy50nJBqPni8Hu3wQYjkkjGWW7/8oAnONdz6I7oOeIFx4T+KB2Vtt15+8z6j8aulOhrBG2Y6+MaHHSoiWh26RCV2IEQUiXukXAGqBXgEPtyvzjakDvRJ9GgFLNhhe+xGtZjVpqhxeuNVvzy2XwnFJuyfnVVQq0MbSfZltThCB8Qs64gdLtWrocFDxhKCJPyC6VBThJwUdUkcr7k+WpI/TgwR1vbOirSCpmGF/7cxgmr65TP+SH4FTt/LaYGNzGBip08fLxWvDvU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:; 
 IPV:NLI; SFV:NSPM;
 H:PH7PR21MB3878.namprd21.prod.outlook.com; PTR:; CAT:NONE; 
 SFS:(13230028)(4636009)(39860400002)(396003)(366004)(376002)(346002)(136003)(451199021)(66476007)(64756008)(66446008)(186003)(316002)(86362001)(52536014)(5660300002)(7416002)(66946007)(71200400001)(4326008)(76116006)(66556008)(54906003)(110136005)(8990500004)(30864003)(2906002)(8936002)(8676002)(9686003)(7696005)(6506007)(53546011)(478600001)(41300700001)(83380400001)(10290500003)(33656002)(55016003)(122000001)(38100700002)(38070700005)(82960400001)(82950400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?V+xgG5GZS5P6AhfXqTWaudqLby7vHNL11belfQoOBBFYCjVi7y/I+/caO8lx?=
 =?us-ascii?Q?QrS/fER9cURTo6y5uJ/lA8E82B5tooiq3z/FqdY1RQK7HS4T8Qu3oUE878ik?=
 =?us-ascii?Q?i5/Wt7v2SXMbphE/Yl87MCY6NUl5HZwmPCo3kC/LzRTcRYsEYSG8snXPtBt2?=
 =?us-ascii?Q?BW/K5vamvWREOxnBlDBvg1Uqa7aHi4cvkwi9lxfEgWimxjavJ1lFTnRoaXET?=
 =?us-ascii?Q?GqHcxPcXkjqMw1+mBgmc89pgSwMcch8tqYLZc77RLydo8L7YWL+N4KEOti09?=
 =?us-ascii?Q?Z3e60bDiH5q+gNyRAD6p/ReG5AjrORvn+6COg6DyilRqGyj2gwjM+XnhX5dT?=
 =?us-ascii?Q?aY/gkBMp23puOVXxQEAsJm2pKEkmXrXm/pVf4bQ8YaqFDWZacYc+MrLfDrvV?=
 =?us-ascii?Q?0dz+bIVrZH1GgFZHdV7VznInZwooZCf5I8gF/yPqMDJfnfIumEkPROO68pao?=
 =?us-ascii?Q?qIflosYIm5M5OvYrjedL68H3hZrqFlnYtfIQ++cZaejD75V1KCaHK667W1mL?=
 =?us-ascii?Q?pfKPEIjMv88OhH7JP54/PS/WbY09paJyWpv6p/NaQ4TJA37L+mgP566EYWWS?=
 =?us-ascii?Q?c1fdwTjVWKreNyZ3MMsads7x4XAsLgMKKwAnE+nRaJDiDA7aL0eNrW648tFh?=
 =?us-ascii?Q?FejLrGQPW/CViWotGS0+dTsHZwGcb/DLN21lrRaNNOo7TEvSubC/tMtde8Jm?=
 =?us-ascii?Q?GLBBYZ8wO/STRrR8cZoNZVe9soYm6OSpFa+0wmOWfP5weNL95tZML9TeBd+n?=
 =?us-ascii?Q?qwvc0ylWWsiTHjFGlE4MjIVXal+vBKN8zmsLM1rCDhr4CxnsbbpE5iQkChBe?=
 =?us-ascii?Q?FCUD62t3gJozUkyYXrA1hpSt67fI/KAwwupntMm0CP9/AJD/4PVUCw7hiCUo?=
 =?us-ascii?Q?BieDAW/hbzB8lz70bKL3Bpz0U3Ie3HJ1dHVB3pnytPTpcrrdHDRUmA5kL6SM?=
 =?us-ascii?Q?z55MBuQwR0mrmjaCV+osBOXaPmTgcKMY9MbzQSgue8SeuAMz9Ny/L7Y6C5zL?=
 =?us-ascii?Q?j37rIeBmS2FBbTTiKiUdZ3KF8/TG+aMTASMJrjhJuCoU3WUX78QVsbsGvDbL?=
 =?us-ascii?Q?54HiNmB7+HRxj3HLWtEz24+aiHPKFxSUS0D0Cz0Rh72vhaVNqeEdlc2wMkYE?=
 =?us-ascii?Q?sG3lkqOlEQ66qpZqSVd8H82TqAX5E6Ia8h3nDbdJqeU7qhPokY9FFZLFguec?=
 =?us-ascii?Q?ALn8nA0szT51Dk6z+dwQmc9/NoOLS8Q2C49qHYBoRSpM5J6fZZmfwEZ+qD3v?=
 =?us-ascii?Q?8IDVpfqqs25ce0seRUhv+S2n92hhwIjn6CvoxQHBc97aqyszoPwcOm5ZFK3+?=
 =?us-ascii?Q?j9mVP/Q3tKXy0McYmladEuYJa0VU6Diu3ugmQGaBmaO2IYuFo/l6ug1zBG8Q?=
 =?us-ascii?Q?kCFdqsro5MjmAAKSzg4uw1RfP9YgxMW3piQzLwHqOd34N28neAD0YIsAIn8G?=
 =?us-ascii?Q?D1iaxoXO27siLwHW3Z9wc0VjLZ2dN7FLZGNFB/F91OQX9a7zgfJnLvoXh5qS?=
 =?us-ascii?Q?MXjxSrDQLt0+s51s0UwmYbavshxL5SjaR84UsFNlqt65P+x3iEgkQrfdoC4K?=
 =?us-ascii?Q?oEfkj01ZMGTDHFHXO5JxS9yQyE7eqnbOE9CTXBLm3AYX4KPnL5RjIfVU7uiM?=
 =?us-ascii?Q?TV8jWMYJ/WQcnMRgt4BIDpZaZWLa4q9c9MWuUC7zr0V3DRDRQaWZzS+5Zulz?=
 =?us-ascii?Q?FRS/Cg=3D=3D?=
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR21MB3878.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 566dc28a-7d39-41fd-993f-08db8e26664d
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2023 22:19:37.9056 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qTGPjIXyuQhm+LLXndVkBCDDWVX5ARGznUdkv0LgR6VFhr3aurvCz7TfQjezxJXkzp5ebDVkK/UlUNi0KeWEu0MLfQeg49Rzf0s9tPWl0mI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR21MB3540
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/1URSm43vx_B39F8UWtO12egdYLg>
Subject: Re: [Bpf] [PATCH bpf-next v4 17/17] docs/bpf: Add documentation for
 new instructions
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

> -----Original Message-----
> From: Yonghong Song <yonghong.song@linux.dev>
> Sent: Wednesday, July 26, 2023 3:09 PM
> To: Alexei Starovoitov <ast@kernel.org>; Andrii Nakryiko
> <andrii@kernel.org>; bpf@vger.kernel.org; Daniel Borkmann
> <daniel@iogearbox.net>; Martin KaFai Lau <martin.lau@kernel.org>
> Cc: David Faust <david.faust@oracle.com>; Fangrui Song
> <maskray@google.com>; Jose E . Marchesi <jose.marchesi@oracle.com>;
> kernel-team@fb.com
> Subject: [PATCH bpf-next v4 17/17] docs/bpf: Add documentation for new
> instructions
> 
> Add documentation in instruction-set.rst for new instruction encoding and
> their corresponding operations. Also removed the question related to 'no
> BPF_SDIV' in bpf_design_QA.rst since we have BPF_SDIV insn now.
> 
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  Documentation/bpf/bpf_design_QA.rst           |   5 -
>  .../bpf/standardization/instruction-set.rst   | 115 ++++++++++++------
>  2 files changed, 79 insertions(+), 41 deletions(-)
> 
> diff --git a/Documentation/bpf/bpf_design_QA.rst
> b/Documentation/bpf/bpf_design_QA.rst
> index 38372a956d65..eb19c945f4d5 100644
> --- a/Documentation/bpf/bpf_design_QA.rst
> +++ b/Documentation/bpf/bpf_design_QA.rst
> @@ -140,11 +140,6 @@ A: Because if we picked one-to-one relationship to
> x64 it would have made  it more complicated to support on arm64 and other
> archs. Also it  needs div-by-zero runtime check.
> 
> -Q: Why there is no BPF_SDIV for signed divide operation?
> -~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> -A: Because it would be rarely used. llvm errors in such case and -prints a
> suggestion to use unsigned divide instead.
> -
>  Q: Why BPF has implicit prologue and epilogue?
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>  A: Because architectures like sparc have register windows and in general diff
> --git a/Documentation/bpf/standardization/instruction-set.rst
> b/Documentation/bpf/standardization/instruction-set.rst
> index 751e657973f0..f36bee41c719 100644
> --- a/Documentation/bpf/standardization/instruction-set.rst
> +++ b/Documentation/bpf/standardization/instruction-set.rst
> @@ -154,24 +154,27 @@ otherwise identical operations.
>  The 'code' field encodes the operation as below, where 'src' and 'dst' refer  to
> the values of the source and destination registers, respectively.
> 
> -========  =====
> ==========================================================
> -code      value  description
> -========  =====
> ==========================================================
> -BPF_ADD   0x00   dst += src
> -BPF_SUB   0x10   dst -= src
> -BPF_MUL   0x20   dst \*= src
> -BPF_DIV   0x30   dst = (src != 0) ? (dst / src) : 0
> -BPF_OR    0x40   dst \|= src
> -BPF_AND   0x50   dst &= src
> -BPF_LSH   0x60   dst <<= (src & mask)
> -BPF_RSH   0x70   dst >>= (src & mask)
> -BPF_NEG   0x80   dst = -src
> -BPF_MOD   0x90   dst = (src != 0) ? (dst % src) : dst
> -BPF_XOR   0xa0   dst ^= src
> -BPF_MOV   0xb0   dst = src
> -BPF_ARSH  0xc0   sign extending dst >>= (src & mask)
> -BPF_END   0xd0   byte swap operations (see `Byte swap instructions`_
> below)
> -========  =====
> ==========================================================
> +========  =====  =======
> ==========================================================
> +code      value  offset   description
> +========  =====  =======
> ==========================================================
> +BPF_ADD   0x00   0        dst += src
> +BPF_SUB   0x10   0        dst -= src
> +BPF_MUL   0x20   0        dst \*= src
> +BPF_DIV   0x30   0        dst = (src != 0) ? (dst / src) : 0
> +BPF_SDIV  0x30   1        dst = (src != 0) ? (dst s/ src) : 0
> +BPF_OR    0x40   0        dst \|= src
> +BPF_AND   0x50   0        dst &= src
> +BPF_LSH   0x60   0        dst <<= (src & mask)
> +BPF_RSH   0x70   0        dst >>= (src & mask)
> +BPF_NEG   0x80   0        dst = -src
> +BPF_MOD   0x90   0        dst = (src != 0) ? (dst % src) : dst
> +BPF_SMOD  0x90   1        dst = (src != 0) ? (dst s% src) : dst
> +BPF_XOR   0xa0   0        dst ^= src
> +BPF_MOV   0xb0   0        dst = src
> +BPF_MOVSX 0xb0   8/16/32  dst = (s8,s16,s32)src
> +BPF_ARSH  0xc0   0        sign extending dst >>= (src & mask)
> +BPF_END   0xd0   0        byte swap operations (see `Byte swap instructions`_
> below)
> +========  =====  ============
> +==========================================================
> 
>  Underflow and overflow are allowed during arithmetic operations, meaning
> the 64-bit or 32-bit value will wrap. If eBPF program execution would @@ -
> 198,11 +201,20 @@ where '(u32)' indicates that the upper 32 bits are
> zeroed.
> 
>    dst = dst ^ imm32
> 
> -Also note that the division and modulo operations are unsigned. Thus, for -
> ``BPF_ALU``, 'imm' is first interpreted as an unsigned 32-bit value, whereas -
> for ``BPF_ALU64``, 'imm' is first sign extended to 64 bits and the result -
> interpreted as an unsigned 64-bit value. There are no instructions for -signed
> division or modulo.
> +Note that most instructions have instruction offset of 0. But three
> +instructions (BPF_SDIV, BPF_SMOD, BPF_MOVSX) have non-zero offset.
> +
> +The devision and modulo operations support both unsigned and signed
> flavors.
> +For unsigned operation (BPF_DIV and BPF_MOD), for ``BPF_ALU``, 'imm' is
> +first interpreted as an unsigned 32-bit value, whereas for
> +``BPF_ALU64``, 'imm' is first sign extended to 64 bits and the result
> +interpreted as an unsigned 64-bit value.  For signed operation
> +(BPF_SDIV and BPF_SMOD), for ``BPF_ALU``, 'imm' is interpreted as a
> +signed value. For ``BPF_ALU64``, the 'imm' is sign extended from 32 to 64
> and interpreted as a signed 64-bit value.
> +
> +Instruction BPF_MOVSX does move operation with sign extension.
> +``BPF_ALU | MOVSX`` sign extendes 8-bit and 16-bit into 32-bit and upper
> 32-bit are zeroed.
> +``BPF_ALU64 | MOVSX`` sign extends 8-bit, 16-bit and 32-bit into 64-bit.
> 
>  Shift operations use a mask of 0x3F (63) for 64-bit operations and 0x1F (31)
> for 32-bit operations.
> @@ -210,21 +222,23 @@ for 32-bit operations.
>  Byte swap instructions
>  ~~~~~~~~~~~~~~~~~~~~~~
> 
> -The byte swap instructions use an instruction class of ``BPF_ALU`` and a 4-bit
> -'code' field of ``BPF_END``.
> +The byte swap instructions use instruction classes of ``BPF_ALU`` and
> +``BPF_ALU64`` and a 4-bit 'code' field of ``BPF_END``.
> 
>  The byte swap instructions operate on the destination register  only and do
> not use a separate source register or immediate value.
> 
> -The 1-bit source operand field in the opcode is used to select what byte -
> order the operation convert from or to:
> +For ``BPF_ALU``, the 1-bit source operand field in the opcode is used
> +to select what byte order the operation convert from or to. For
> +``BPF_ALU64``, the 1-bit source operand field in the opcode is not used and
> must be 0.
> 
> -=========  =====
> =================================================
> -source     value  description
> -=========  =====
> =================================================
> -BPF_TO_LE  0x00   convert between host byte order and little endian
> -BPF_TO_BE  0x08   convert between host byte order and big endian
> -=========  =====
> =================================================
> +=========  =========  =====
> =================================================
> +class      source     value  description
> +=========  =========  =====
> =================================================
> +BPF_ALU    BPF_TO_LE  0x00   convert between host byte order and little
> endian
> +BPF_ALU    BPF_TO_BE  0x08   convert between host byte order and big
> endian
> +BPF_ALU64  BPF_TO_LE  0x00   do byte swap unconditionally
> +=========  =========  =====
> +=================================================
> 
>  The 'imm' field encodes the width of the swap operations.  The following
> widths  are supported: 16, 32 and 64.
> @@ -239,6 +253,12 @@ Examples:
> 
>    dst = htobe64(dst)
> 
> +``BPF_ALU64 | BPF_TO_LE | BPF_END`` with imm = 16/32/64 means::
> +
> +  dst = bswap16 dst
> +  dst = bswap32 dst
> +  dst = bswap64 dst
> +
>  Jump instructions
>  -----------------
> 
> @@ -249,7 +269,8 @@ The 'code' field encodes the operation as below:
>  ========  =====  ===  ===========================================
> =========================================
>  code      value  src  description                                  notes
>  ========  =====  ===  ===========================================
> =========================================
> -BPF_JA    0x0    0x0  PC += offset                                 BPF_JMP only
> +BPF_JA    0x0    0x0  PC += offset                                 BPF_JMP class
> +BPF_JA    0x0    0x0  PC += imm                                    BPF_JMP32 class
>  BPF_JEQ   0x1    any  PC += offset if dst == src
>  BPF_JGT   0x2    any  PC += offset if dst > src                    unsigned
>  BPF_JGE   0x3    any  PC += offset if dst >= src                   unsigned
> @@ -278,6 +299,16 @@ Example:
> 
>  where 's>=' indicates a signed '>=' comparison.
> 
> +``BPF_JA | BPF_K | BPF_JMP32`` (0x06) means::
> +
> +  gotol +imm
> +
> +where 'imm' means the branch offset comes from insn 'imm' field.
> +
> +Note there are two flavors of BPF_JA instrions. BPF_JMP class permits
> +16-bit jump offset while
> +BPF_JMP32 permits 32-bit jump offset. A >16bit conditional jmp can be
> +converted to a <16bit conditional jmp plus a 32-bit unconditional jump.
> +
>  Helper functions
>  ~~~~~~~~~~~~~~~~
> 
> @@ -320,6 +351,7 @@ The mode modifier is one of:
>    BPF_ABS        0x20   legacy BPF packet access (absolute)   `Legacy BPF
> Packet access instructions`_
>    BPF_IND        0x40   legacy BPF packet access (indirect)   `Legacy BPF Packet
> access instructions`_
>    BPF_MEM        0x60   regular load and store operations     `Regular load and
> store operations`_
> +  BPF_MEMSX      0x80   sign-extension load operations        `Sign-extension
> load operations`_
>    BPF_ATOMIC     0xc0   atomic operations                     `Atomic operations`_
>    =============  =====  ====================================
> =============
> 
> @@ -350,9 +382,20 @@ instructions that transfer data between a register
> and memory.
> 
>  ``BPF_MEM | <size> | BPF_LDX`` means::
> 
> -  dst = *(size *) (src + offset)
> +  dst = *(unsigned size *) (src + offset)
> +
> +Where size is one of: ``BPF_B``, ``BPF_H``, ``BPF_W``, or ``BPF_DW``
> +and 'unsigned size' is one of u8, u16, u32 and u64.
> +
> +The ``BPF_MEMSX`` mode modifier is used to encode sign-extension load
> +instructions that transfer data between a register and memory.
> +
> +``BPF_MEMSX | <size> | BPF_LDX`` means::
> +
> +  dst = *(signed size *) (src + offset)
> 
> -Where size is one of: ``BPF_B``, ``BPF_H``, ``BPF_W``, or ``BPF_DW``.
> +Where size is one of: ``BPF_B``, ``BPF_H`` or ``BPF_W``, and 'signed
> +size' is one of s8, s16 and s32.
> 
>  Atomic operations
>  -----------------
> --
> 2.34.1
> 

All changes under the "standardization" directory should also cc bpf@ietf.org,
so adding that DL to the cc line for this thread.

Dave

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

