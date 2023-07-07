Return-Path: <bpf+bounces-4454-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A96774B579
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 18:56:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DAD41C21028
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 16:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 486D31119D;
	Fri,  7 Jul 2023 16:56:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDCC3D511
	for <bpf@vger.kernel.org>; Fri,  7 Jul 2023 16:56:01 +0000 (UTC)
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C52E0B2
	for <bpf@vger.kernel.org>; Fri,  7 Jul 2023 09:56:00 -0700 (PDT)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 96AB3C151992
	for <bpf@vger.kernel.org>; Fri,  7 Jul 2023 09:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1688748960; bh=LwUEJrhFn9PX5TjJoeKF13GTe3yXp0YYt20kkSwDAzc=;
	h=To:CC:Date:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ITl+GLUsC6Zgeu89nVKffs/tyKAfxIGLzW2tWssw+wKbhFXMBwkoBqx+yaT0u8Qup
	 lei6d10pXVKJryKQ2iYWw8eyGndDuAGwfjEizRIPWbO2x3+3dSuSERevHD7FejuPyL
	 2p6tHU5EM7nZgIM9MLawc4sMtcKTu6Mt22McSrxw=
Received: from ietfa.amsl.com (localhost [IPv6:::1])
 by ietfa.amsl.com (Postfix) with ESMTP id 7712DC1516F8;
 Fri,  7 Jul 2023 09:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
 t=1688748960; bh=LwUEJrhFn9PX5TjJoeKF13GTe3yXp0YYt20kkSwDAzc=;
 h=From:To:CC:Date:References:In-Reply-To:Subject:List-Id:
 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
 b=p/RqWvvyhp80rw0VeC6NWei9SNpoMTS65uiOjy78GYZPTG4TisIjwpHJ/+HfQ9NbZ
 uzjBosz+McWv98W7amZja4pGAY9gyMNFP8SxadVYDdW38QKhrXD5wOL3XJzKq8ojMD
 yRdMLfrlfL0sXbGLtkMEGQTzpFTfL6Wnezp89C6I=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id F39C6C1516F8
 for <bpf@ietfa.amsl.com>; Fri,  7 Jul 2023 09:55:58 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Score: -2.101
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (1024-bit key)
 header.d=microsoft.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id R5puP_6nCZQ0 for <bpf@ietfa.amsl.com>;
 Fri,  7 Jul 2023 09:55:56 -0700 (PDT)
Received: from BN3PR00CU001.outbound.protection.outlook.com
 (mail-eastus2azon11020014.outbound.protection.outlook.com [52.101.56.14])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id B1832C1516E0
 for <bpf@ietf.org>; Fri,  7 Jul 2023 09:55:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X8YESlRty3vEKjy2L/mpC7Tk2xKtqR1C/yLb7i4ZjWlxcx4y6RQhaAailJxCgC3grGw/BE4zoRTwPSCwGpaBTL3RrBNfV9RWUrgoPafhEoCXZNc8qzn+JRLbSHOO0CKLepKtopZgAaDKC8BoGdrMmycyEY+V8IuFgWp7yvXKwdtqmjp3kqpyy4PsbImaTcBSI0qACCrHglVBYCmab3aWscPswomtg2wQTpFweeIbzOxEIQEck7etuS7FiO7Nco87/7WRhFf3sJ7RYpDLj1tfu4dOAUQj7a8KFMg8VaKKPCbyEoH/D08WwWIFWSSXIkGLYGArzjaijm2eL3us7A8lQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gJfB+UhE3Y9PZTYsHsrIXux32cU4JOCsrGCYnRxZPeI=;
 b=T75b+R39DPtOwl4WwZ8aiJqfYFoGta+mUfchsvWkFw4Rv1O7RNEbZTZSpMSs0vV6ExVzdvvQ5k0+MfMWgKahxPCWdO1eHulNsiUSUCDhwO3UUIKpe5a05OJiuYXIZUL1PchMQpRn+A8RXIRyizWszq2JoEzLbpcj63QlsMQfMAVyJp5ZwDHJ83g/xPVlomJaZiVmilUlbx69kpXLblB5vifb1SQFn8r/gnCxUlaWTVz7XXAADzFHzkqvetPtpdnAe3ykh8dBHeMWQKqtRR6fLLndg/gfxx99owJPD7RAW3Tfks1Jp2IQzlcVJ9OvmPEnHMPd7cyomYl+Vu3DRP4cdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gJfB+UhE3Y9PZTYsHsrIXux32cU4JOCsrGCYnRxZPeI=;
 b=VGCErMZrI3oszIMAxlfAj+gGzpwvH1yPlNWTNwODK8QQrUPk8rFrw2YlhNbZfKlFM2VhpzJFmukv5FfnIy+fkBexobQKiYEMmkrt54Ym5J8xwEbi+00p+c3+JZrT5Q/kSQxGgFOcgexKB23zAxnrhJvXj9Q5MUv9zvGDhJpLIAQ=
Received: from PH7PR21MB3878.namprd21.prod.outlook.com (2603:10b6:510:243::22)
 by MN2PR21MB1534.namprd21.prod.outlook.com (2603:10b6:208:202::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.13; Fri, 7 Jul
 2023 16:55:53 +0000
Received: from PH7PR21MB3878.namprd21.prod.outlook.com
 ([fe80::8708:6828:fb9f:7bd5]) by PH7PR21MB3878.namprd21.prod.outlook.com
 ([fe80::8708:6828:fb9f:7bd5%4]) with mapi id 15.20.6544.010; Fri, 7 Jul 2023
 16:55:53 +0000
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC: "bpf@ietf.org" <bpf@ietf.org>, bpf <bpf@vger.kernel.org>, Will Hawkins
 <hawkinsw@obs.cr>
Thread-Topic: [Bpf] Instruction set extension policy
Thread-Index: AdmwKdCg+G2TzllJT+2ICM2r0nWi5AAR1CgAAABLvuAAHnesgAAAP1QAAAFmaSA=
Date: Fri, 7 Jul 2023 16:55:53 +0000
Message-ID: <PH7PR21MB3878B1E6B39D36CBB5C65181A32DA@PH7PR21MB3878.namprd21.prod.outlook.com>
References: <PH7PR21MB387813A79D0094E47914C5A8A32CA@PH7PR21MB3878.namprd21.prod.outlook.com>
 <CAADnVQJhfa+g227BX=3LijoXwgh7h3Z5V_ZF8tMeMWNZguAp5g@mail.gmail.com>
 <PH7PR21MB3878DEA7280C274A8A18D082A32DA@PH7PR21MB3878.namprd21.prod.outlook.com>
 <CAADnVQ+ogOVdwZSX4315hHe8bxP-yoYEacNPCP6CTHqn=Xp-uQ@mail.gmail.com>
 <CADx9qWjUj5YP6Dr9g2GY6Yrf4-1K+5-v6wE6gYV_R9e3OjBnLw@mail.gmail.com>
In-Reply-To: <CADx9qWjUj5YP6Dr9g2GY6Yrf4-1K+5-v6wE6gYV_R9e3OjBnLw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=537a9fa0-a6bd-41be-ac12-84577e2da1ad;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-07-07T16:47:53Z; 
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR21MB3878:EE_|MN2PR21MB1534:EE_
x-ms-office365-filtering-correlation-id: e79be928-f662-4af2-7244-08db7f0b0656
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sK/KEmW8ELm6nZizoLOvshJp9VkmgHT1h7z+1EdHSOMY1d0EHUjOiYRUHRpFTauFUJYRQaTcE/1gpuDTHPtZq4WfK5W9q3uzanYW0NGm3Ms4OvEwCzAWn80N2EodBX95QCwPbdO/li8aIf7Y34PEDLnP6WLol3PVnTWHQx5avvn30m8yC5Eh+71OsX1QZGInA2OLXcm1p232iZG1JkF0n68e7UB8VTdxOui4E52QxcBQFNOEGMWl3RxK3odGHKQgRbFIScTRjODSSFYU5T9WaMPvxKJc/bFw+Z2El5QTyEIJGRJTbRL1gEir3UXu4ANn7ETaOvbdMPgoe3Qr/LB4uRyHJ22yXq7mqjBEGVQn8uSwGaPe/nrZhTJTEApcbzNSvA+ciJpTKsgE6fRM6bXVqaSgMbvsfLT1AiwT6jjn6QA8VHd/88UgEFk7C0IFG2Ksro/H371nNHBUfboYbKQ6Ihz9PN6bUeo04wxo/RDsvH/mPlDdODEMwXIOex7h6ciz1MmEDr/oxta3+xYQQ6rV4DVwRkaaWf1WXFCSj9OIv/u4vr7JJtbC1Cqdt+G/w+K+Y5EGdxV6Gp1i8ADptp3gUmBBjuzWuBGG0iNKbVqZ0uSjeGj/dBNsqSIybUbPYbO9SapAvHCuay/ko1QEiOmaceutSblohcXrx0BNXQjH14o=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:; 
 IPV:NLI; SFV:NSPM;
 H:PH7PR21MB3878.namprd21.prod.outlook.com; PTR:; CAT:NONE; 
 SFS:(13230028)(4636009)(346002)(39860400002)(366004)(396003)(136003)(376002)(451199021)(55016003)(41300700001)(83380400001)(2906002)(66574015)(86362001)(52536014)(478600001)(10290500003)(71200400001)(7696005)(186003)(9686003)(26005)(33656002)(38070700005)(6506007)(53546011)(8676002)(5660300002)(8936002)(54906003)(122000001)(76116006)(82960400001)(82950400001)(8990500004)(38100700002)(64756008)(316002)(66446008)(66556008)(66476007)(66946007)(4326008)(6916009);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eXNrY3gvVjBmeS81QkxBYzB4UFk1VFQ4Vlg5elhOUzNpTFN1Vmk5OHlsb3pV?=
 =?utf-8?B?ajM2TXZQMEpOSHdOQnZQdW1pcmFIK0ttcFVVTnVtcVFLTTZncGo0QlBDQWxU?=
 =?utf-8?B?RUNKYncrNFV3SHdKMHgzcXk1MTQ1Q0hIdGRxUG5nTU8yNjdudnFLa2szb2dC?=
 =?utf-8?B?bFA4T1JwNWthSkcvSXFabTRMMHB0WHpUbWtNT3NMQ3ZNd1FKV1NwZkxhenRj?=
 =?utf-8?B?UUN4RUZKcWxQRnlBeWJsQTVPQTN2MHdtY00vYXdZQnNkbDY1OVA5SnBjenN6?=
 =?utf-8?B?UzcwZ1Z1b3ZnSnZ0Q2FJaTI4Z3FCVm1lUXVrOUw1SS9qcnFNa04xUndQSkJE?=
 =?utf-8?B?WldyS3lEZnhaSVRiWG4ycldmTGNMczJMNE4yQVM0YnJyeTRFWHgySzdYcUZT?=
 =?utf-8?B?QVdDUFVqQ3BqRXJva0YxZlIxclFpTjl4RjQ1MCsyUHk3RDVmQUY1OUI0VStp?=
 =?utf-8?B?TkVRRU1qOW9tamJOMFIyRzN2dnBOVnNvM2pGNlFhUDNrMG5td3VmK1hPejNH?=
 =?utf-8?B?K2w1dHFxazU2TThkNVdUQklwZG1mUlZWV0ppY0ZVendlcERWQVVWZTBSSUd2?=
 =?utf-8?B?ZFR4bEl6c0xQTTAzQVdNdXNnS2FDdnIvakpYWjlYdFRKNEZwYXpoUVU2bmVy?=
 =?utf-8?B?dEh5NlhGKy9UZkM2NlZRTzVxQTdDZEZaemtCOUdscVBWYkJBYzZtbGNsYzRB?=
 =?utf-8?B?bmpab3lHSk96dG9mOXJFQlk2b1JMVFcwRXJwWnFyYkgyaDFRZEUvTndOSWlX?=
 =?utf-8?B?NXdCcWRGdG92bWZ0ZjZrT21scGIyL1UrZ3B1VlpLR1dZU1BmbjV5WWM4L0ty?=
 =?utf-8?B?Vm9BVzlic3I5TjdPa3RUYUY5dlM3eUlKNTFUekNoZ3NER3J0ZzRuYkhrbXVu?=
 =?utf-8?B?N3N2QjJ5SUZ4c1hlWndBN1V2M0R5dDIyQ3crU2xUallyb3FSdm1mazZpdGEw?=
 =?utf-8?B?ZGxvVmg4U25CT21obVNYYWNMdjdLMHhhKzJCQkROUGRxZ1RLcE1HM2hDZ28r?=
 =?utf-8?B?Zk5OSkwyY3FXNUtYcXc5cnBRMmFObUYyTERUZVl5L3NoS2dUUndsbGszQzVB?=
 =?utf-8?B?MnlhMlo0SW1lSVBPY3JtNmozWEZBa0xlajRMMmFJbGFuVjhUd0hUZDJiQ2RV?=
 =?utf-8?B?Z25PTlpWalcrZG54ZklvVHdkbENBdlEwYUR6UHlaT1dVU1hYcmlRQTZpbHZn?=
 =?utf-8?B?V1EvbkdzM1c0b0pFaktCVXE5S1NvM1NOYkFYcmRqWFB2TFpzeEx2eFFDcXRN?=
 =?utf-8?B?RnFDejJ5TlVqOXFzQkZPcThwUVQ4YktBQktJTHE0QWNaRzk5RmswSHBpY1JM?=
 =?utf-8?B?bmFueTNZRStNWkwvQzVqRFRLYTl4QkRuUnJ1L3BrOUhaQXlCRFdyVjFLc3Y4?=
 =?utf-8?B?aGhoWGtuYVdYc3V2bDVDNG1DT1JKZFBhRGpHL296R2xOMDJMRTNSMmdDbjg3?=
 =?utf-8?B?RjNjaHN6bWRuQnBpQ0ZmNVMxc3ZjZjhNZjBYSmVRaUtKdUVxcmxxUTBYK040?=
 =?utf-8?B?dFZDbGR4OUN0R2x5NXpCWE9NSU5oNkR0N3I0dVJXU3lQMC9UM1dHc01DV1Q3?=
 =?utf-8?B?aitCNXBnU3cwWmV4bWFYRHpGZmtZTWdEV1Z0YXc5elk2UG9TcHM0cktQanV3?=
 =?utf-8?B?L0dWd0JnaTViZzR4c3drcWpQazdPaTNTMFpTOTRmSXpKblcyaUJNU3V5UmlU?=
 =?utf-8?B?UWxneWVPVDBVdE5ZV2QzbHZMVjUwb2k3bmpOTmxkUGpEMnBRamdVQjRWdlVo?=
 =?utf-8?B?dVpDUi9RRWErZEE3cDhTeXBZanYrdHlRazJCdFhUZmIvOTh2QVU2U0RuVSti?=
 =?utf-8?B?M2twWFVvUzdTWnlVOGxZcThDckVsaW9NRk16aUViVkRQNGZiWUhXWEtNY0Y2?=
 =?utf-8?B?UUZXcXA5d3duSGp0cWU5d2pxTHhiYWdSR2NYZHN0c1cyZ0ZIMDFTeS9XamFW?=
 =?utf-8?B?dUhJNUNscGxMeFdaaGY5cFlUeDFUbW0yRXZqQU04TmpHYzhuUkFTQWZNZnl4?=
 =?utf-8?B?RG5LNm5iUWxtS0lvblhiSE9SRlAzNW5ub0R4ZjM4Y0k1U0o4TkVBVTJNODFx?=
 =?utf-8?B?Q243SlVwa1kvS2MyY0FHQnRtTjNuNWdqMHo2NDViczdiZnpZYjJlU2NPcDBt?=
 =?utf-8?B?d0MyTHdOdEZXL1FoZ24xdmdlMEZPNnBocjRjZUY5VEtNZnFFWld1WjFqTnBY?=
 =?utf-8?B?c2c9PQ==?=
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR21MB3878.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e79be928-f662-4af2-7244-08db7f0b0656
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2023 16:55:53.0523 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Jqgkn8ucn9QP3wlY3q0PxchkEGOiZraYcj0U0g3iYrkgjUYCvI7/kHYHunfWq/rKTV0rX+OWm06OsHwdFipD47mctnz8aperu1Ir2F3qFSU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR21MB1534
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/5lGK69Y3SQkluEbbS11zG9yiinU>
Subject: Re: [Bpf] Instruction set extension policy
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: bpf-bounces@ietf.org
Sender: "Bpf" <bpf-bounces@ietf.org>
X-Original-From: Dave Thaler <dthaler@microsoft.com>
From: Dave Thaler <dthaler=40microsoft.com@dmarc.ietf.org>
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

QWxleGVpIFN0YXJvdm9pdG92IDxhbGV4ZWkuc3Rhcm92b2l0b3ZAZ21haWwuY29tPiB3cm90ZToN
Cj4gPiBPbiBUaHUsIEp1bCA2LCAyMDIzIGF0IDY6MzXigK9QTSBEYXZlIFRoYWxlciA8ZHRoYWxl
ckBtaWNyb3NvZnQuY29tPg0KPiB3cm90ZToNCj4gPiA+DQo+ID4gPiBJIGRvbid0IHNlZSBhbnkg
cHJvYmxlbSB3aXRoIGRlZmluaW5nIGFuIElBTkEgcmVnaXN0cnkgd2l0aCBtdWx0aXBsZQ0KPiA+
ID4gImtleSIgZmllbGRzIChvcGNvZGUrc3JjK2ltbSkuICBBbGwgZXhpc3RpbmcgaW5zdHJ1Y3Rp
b25zIGNhbiBiZSBkb25lIGFzDQo+IHN1Y2guDQo+ID4gPg0KPiA+ID4gQmVsb3cgaXMgc3RyYXdt
YW4gdGV4dCB0aGF0IEkgdGhpbmsgZm9sbG93cyBJQU5BJ3MgcmVxdWlyZW1lbnRzDQo+ID4gPiBv
dXRsaW5lZCBpbiBSRkMgODEyNi4uLg0KWy4uXQ0KPiA+IEkgdGhpbmsgdGhhdCBtaWdodCB3b3Jr
LiBXaGF0IGlzIHRoZSBuZXh0IHN0ZXAgdGhlbj8NCj4gPiBXaG8gaXMgZ29pbmcgdG8gZ2VuZXJh
dGUgc3VjaCBhIGhleCBkYXRhYmFzZT8NCj4gDQo+IEkgd291bGQgYmUgbW9yZSB0aGFuIGhhcHB5
IHRvIGRvIHRoYXQhDQo+IFdpbGwNCg0KUkZDIDgxMjYgcmVxdWlyZXMgc3BlY2lmeWluZyB0aGUg
aW5pdGlhbCBzZXQgb2YgaXRlbXMgaW4gdGhlIGRyYWZ0LCB3aGljaA0KdXBvbiBwdWJsaWNhdGlv
biwgSUFOQSB3aWxsIHVzZSBhcyB0aGUgc2VlZCBsaXN0IGFuZCB0aGVuIGJlIHRoZSBvZmZpY2lh
bA0KbGlzdCBvZiB3aGF0IGlzIHJlZ2lzdGVyZWQuICBJIGFscmVhZHkgaGFkIGEgbGlzdCBpbiB0
aGUgQXBwZW5kaXggb2YgdGhlIGRyYWZ0DQp3aGljaCBjYW4gYmUgdXNlZC91cGRhdGVkIHRvIGJl
IHRoYXQgbGlzdC4NCg0KSSBub3cgaGF2ZSB0aGUgSUFOQSBDb25zaWRlcmF0aW9ucyB0ZXh0IGFi
b3ZlIGluIGEgY2hhbmdlIHRvIHRoZSBJbnRlcm5ldA0KRHJhZnQgYm9pbGVycGxhdGUgdGhhdCBz
dXJyb3VuZHMgdGhlIGluc3RydWN0aW9uLXNldC5yc3QuICBTaW5jZSB0aGUgZGVhZGxpbmUNCmZv
ciBJLUQgc3VibWlzc2lvbiBpcyBNb25kYXksIEkgcGxhbiB0byBtYWtlIHRoZSBjaGFuZ2UgYW5k
IHBvc3QgaXQgb24NCk1vbmRheSBhZnRlciBtYWtpbmcgc3VyZSBhbnkgb3RoZXIgaW5zdHJ1Y3Rp
b24tc2V0LnJzdCBjaGFuZ2VzIGdldCBwaWNrZWQNCnVwLg0KDQpEYXZlDQotLSAKQnBmIG1haWxp
bmcgbGlzdApCcGZAaWV0Zi5vcmcKaHR0cHM6Ly93d3cuaWV0Zi5vcmcvbWFpbG1hbi9saXN0aW5m
by9icGYK

