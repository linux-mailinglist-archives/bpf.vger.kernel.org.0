Return-Path: <bpf+bounces-11478-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 918657BAB52
	for <lists+bpf@lfdr.de>; Thu,  5 Oct 2023 22:14:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id BB621281FE1
	for <lists+bpf@lfdr.de>; Thu,  5 Oct 2023 20:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE60E41E34;
	Thu,  5 Oct 2023 20:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="Zk6sLOk4";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="IvKKLIqi";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="X4FiB37m"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5CC41E2B
	for <bpf@vger.kernel.org>; Thu,  5 Oct 2023 20:14:39 +0000 (UTC)
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 440FF83
	for <bpf@vger.kernel.org>; Thu,  5 Oct 2023 13:14:38 -0700 (PDT)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id DEE01C1522C4
	for <bpf@vger.kernel.org>; Thu,  5 Oct 2023 13:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1696536877; bh=uo/GTT6fR/ZlUB8zoTIAKwlnJIXWWX4f/PcMWDMkLD8=;
	h=To:CC:Date:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Zk6sLOk4wF4QaQEjWtGMveB6l1LSfAYf8TbAk6gj8mPzgOx5UIkPPN+b0msqm8lUG
	 O+GjefZytIp5/lISaO62tET9Hr9ES12EmnBBbtfupYnn6B+tI93GeDhOJSbsYM1QPP
	 ckrZ3Gacd1OMb7STwrRTh2BVTsbNJGyAwKwggjAY=
Received: from ietfa.amsl.com (localhost [IPv6:::1])
 by ietfa.amsl.com (Postfix) with ESMTP id B2212C15107A;
 Thu,  5 Oct 2023 13:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
 t=1696536877; bh=uo/GTT6fR/ZlUB8zoTIAKwlnJIXWWX4f/PcMWDMkLD8=;
 h=From:To:CC:Date:References:In-Reply-To:Subject:List-Id:
 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
 b=IvKKLIqiEDYgAUPse/xtClRJbT2rl8QgXekRskdukUG2BDrp+yeAQcdkWgkze4Fgx
 vb7JDcOhWk0KhkiJ5vOmP9x15xa9iwNrwyKo0MOIDAvlLWAq5G/RtaUuAhTjqRl6Ky
 +c8EYSFh68oUxcXyHUweXL0a5//SdALQ1+ffzUyw=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id ECC54C151076
 for <bpf@ietfa.amsl.com>; Thu,  5 Oct 2023 13:14:36 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Score: -2.11
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (1024-bit key)
 header.d=microsoft.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YSyb5FjqcUM5 for <bpf@ietfa.amsl.com>;
 Thu,  5 Oct 2023 13:14:36 -0700 (PDT)
Received: from BN3PR00CU001.outbound.protection.outlook.com
 (mail-eastus2azon11020025.outbound.protection.outlook.com [52.101.56.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 62CE4C15107A
 for <bpf@ietf.org>; Thu,  5 Oct 2023 13:14:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S04ZkWE9H9sTWBGfPA9J1LVU01r8eTMRhl7J7gJTFJ8vVMLUULdxduOfWzduO3nO37r+EiQyEPWOr6EvKs7Ry/QBFSHzJDdOcZkXmAK/FZp6NUrXNWEsaTXAgjysEZ4VToA3DBKXYmb8/l0R2fD7tX+I60Nq050IfG0eOPzmY0vI7/mYx+PHXQ5vl+7qWF5u7f9MHvC7x5N2AkNyo82KhupucVHnjv0607nWJ23P6jOVxebS1lJGEqtGeCFf7zyTnR4ae0txrkMfwE1qmahm4PLxZS8aqeK4v+Cue5ZunhsWCOLTxVtUkq0AKzT8nSlEE3isj7s65OPKJx0Mek7xog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3wGKjp6cBnc1ewfZ82I/fTKtVWgMASdpXBcu0Nw674Y=;
 b=d1QSN7EtluuCwEgk8vSg0JLekuHiWHHEih1sMrOVTguPFglYoE55WJtsaKH9QIblrIZmXllUjKaVPuPykpRMfW3JpzvFg/uSdLnz/ipwGduW54BsK7esRVTt9ORvu4LowoGOTmcryZz5lP8x4EkD0gorOFV9X57NiHWKh/YXeXYED3eIauXVpVtsuhOjp/bpEcg8EPAGKYatoRXGp53vxK3duzHRHjUicKJ3z1uCgjsNsv9LkZm6UwYl2vAwAUksopi/Hxnf6/FaSdUO4fPhZceOeHSROaOGRSveHyORjAiarHuGhG+km8F4HfzMi3n33a8qWTcWT2rZ4CVWvJnASg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3wGKjp6cBnc1ewfZ82I/fTKtVWgMASdpXBcu0Nw674Y=;
 b=X4FiB37mYrOd1Dtapn9jKDZJvbl84ZnXdyiUSoFbcJ5cCgJK4vq7GSfogo2Yn9VNuoxhXTA3vc4YY/q7rJc0M/ErvTo4FxrXHg4eGhIKVUFImqAdH9ikTBEU3OextCleKCtZLSTKH90vK1OVfRbvcrHdDYDPAM6f5OJSyY8LoEA=
Received: from PH7PR21MB3878.namprd21.prod.outlook.com (2603:10b6:510:243::22)
 by DM4PR21MB3152.namprd21.prod.outlook.com (2603:10b6:8:64::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.7; Thu, 5 Oct
 2023 20:14:33 +0000
Received: from PH7PR21MB3878.namprd21.prod.outlook.com
 ([fe80::a9ea:70b4:adf3:9b08]) by PH7PR21MB3878.namprd21.prod.outlook.com
 ([fe80::a9ea:70b4:adf3:9b08%4]) with mapi id 15.20.6886.011; Thu, 5 Oct 2023
 20:14:33 +0000
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC: "bpf@ietf.org" <bpf@ietf.org>, bpf <bpf@vger.kernel.org>
Thread-Topic: [Bpf] ISA RFC compliance question
Thread-Index: AdnzENHOvm4O8LpYSx6FMQlLag6r9QAAQXugACjsDwABBKlAYA==
Date: Thu, 5 Oct 2023 20:14:33 +0000
Message-ID: <PH7PR21MB3878A25F817337EF14FE039FA3CAA@PH7PR21MB3878.namprd21.prod.outlook.com>
References: <PH7PR21MB387850B8DB6A2A5FB87DAC06A3C0A@PH7PR21MB3878.namprd21.prod.outlook.com>
 <PH7PR21MB3878027C6E6FB01651023912A3C0A@PH7PR21MB3878.namprd21.prod.outlook.com>
 <CAADnVQL69iqzxsNRDLKW22B=3sJpO0Yy2yHzioWZmhtQvUwtTQ@mail.gmail.com>
In-Reply-To: <CAADnVQL69iqzxsNRDLKW22B=3sJpO0Yy2yHzioWZmhtQvUwtTQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=8c65c06e-51a1-41af-b1e0-6a4c094fe43f;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-10-05T20:11:50Z; 
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR21MB3878:EE_|DM4PR21MB3152:EE_
x-ms-office365-filtering-correlation-id: fb674ce0-b2ce-4f9f-175e-08dbc5dfb082
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JfLGDvRbTsyDGQ+p7MKC3o4LSwutvJ4Nwv5GKZ/ijj5gsywZT2FkoWEmV73KPwP4HWuNSlspCyjmpGHOMB5hv9W6A6NO3O/ldaSXJ2oB4kY3ciZ4qeZiV62YiliLnbRtLpLkHMVkDbBkQJ7K6N86TWJhuvHVWm34Q49V6/i89sOehcsjyNSDcGW+KRTNNzCvtQ5w4gwTBUfp2ZIibeNFUIYUuMSttroFk9GUGD6QU/1wsboQrHv9gpBELvNF8I0//Z+kx30pDYk4bpJ35ONQIK7e4xPumaEUKm11iT+aXC4O2Wj6BbuPQkvfTAGZjrvgxAhXgaziKMx2hxClAapfzRka5+Lw4TEJi973HNhAeMfBP899/19E6DtcJbmksA+Vxlxq7N9eRbUcF7w4wEnVm9BTF7qqOgiGVk+dHUWxqWnp1dXwP/6acHIsA1el4j35vZoCLteZ3o2J6rPXW5IMzvLV5ECLQOH1sm1QT2UirF6qJwHeKm6bHajyIenJjj4gSWbGMdjmpQdV9411s4P9QxEqrxAAnozfsDwyeVni+X/d2mIGmCs3hxqXpAZk1l2NDSqh1cODf9HxIJmQzjmZITgMZcbxILh9CljyU27hpL7gCnriAkCqiPACXDsaoTX4YWC38hw70E7at0D5xIbTaedhOrKlOzk3MUzc+xXSC4M=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:; 
 IPV:NLI; SFV:NSPM;
 H:PH7PR21MB3878.namprd21.prod.outlook.com; PTR:; CAT:NONE; 
 SFS:(13230031)(39860400002)(366004)(396003)(346002)(136003)(376002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(9686003)(7696005)(6506007)(53546011)(86362001)(33656002)(55016003)(82960400001)(82950400001)(38100700002)(122000001)(38070700005)(2906002)(71200400001)(10290500003)(478600001)(8936002)(8676002)(4326008)(316002)(52536014)(41300700001)(8990500004)(5660300002)(76116006)(66476007)(54906003)(66556008)(66446008)(64756008)(6916009)(66946007)(26005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ejlTcTlKdTBmMWNUSmpNV1pQSklrVnZxYzFVMENhVS9OTWpKT2NhQTJic1hU?=
 =?utf-8?B?S2dvSkR0MTZ3RWc3YlJHeVVReHBobUNyd2tCeVN6SVhMQ2tnWnBNNHVsbkQ4?=
 =?utf-8?B?bjF0V01yZUhPMGh1VllPU3JCM25nVFczTXJzVDNwUGZGRjhaZWJVQ3YxOGJ0?=
 =?utf-8?B?TjBUaVBEVkQweWxsWEFiU05xWXRDSGtDQWtkUWl5YWZuK2FqWHJTT1NZQnZy?=
 =?utf-8?B?MFovQlEyZENoMEk1YlBjZXBuWW1ReWMvQ09YaE4rOS9ObEQ0NTdITWxlekQ1?=
 =?utf-8?B?bjRFdW5QMm9uNytBb0d5UmRrVngyTDYzeEYvTHZHVUY5RUVncUhjMy9uR0o3?=
 =?utf-8?B?RzRENThvWFRJMFdVcnFobXRSeVgxYVlYbFhia1hvWkpKUEdxQmZoQktPUmhP?=
 =?utf-8?B?Wm43VUYvc1haNGo2Rmg2RGZNWWpDdU5vRWQzdXU2MndXWTNjdlNaWkJHTHNo?=
 =?utf-8?B?K2hLYTFJdjR0ZjVLbUJ1SGx1UlJBYlJzZURwcDZMdTh4TlRKMUY3OVBKTXBs?=
 =?utf-8?B?bnFCK3JVd25PY0dIY1ZkMGc0WjFnbDdmeG1ZTWxKcVYwZUZtOVZ5aEdvdHBv?=
 =?utf-8?B?UzN5TFEvOENXQTZVbXZ3cmhYeG9yUHJLb0s2ZFpsamRRTXVRQko3TElHdFBY?=
 =?utf-8?B?ak93ZFpqcklvODVSaUZoNEkvL1NnZFZsNFVkMUwzV200M1huem9wdGZLWXNr?=
 =?utf-8?B?aUpOaThOdndiQkxiNS9GWFp0bFR0bEphcVZ4Yy9CcTRTZlpzeTNqZ01zM0Rm?=
 =?utf-8?B?N0dlcTVGZ1lCTEpYclpHS1RoK1NFN3hlQUQ2QW5Vak1Fd2pBTEVMVjBac0cz?=
 =?utf-8?B?U2Z1RFRKZE9GaWJzWm9UblhGVDZUSnJlZHdoSjJxS1pLZFdtVytXSGo4OVVv?=
 =?utf-8?B?UU16bEg5d0UxQWdTbE5nV212ZmxJalNJVnZVRWFyL1luUXNEYi9Od1NCT0h4?=
 =?utf-8?B?QjdFV21LWFV3YkdNTGI2Nzd0cGlnaDlWN3dQRUNaS2NTcXdlaFZCUU5uVlJD?=
 =?utf-8?B?Skw5REtWYVZsM21hV1JCM0ROU2hWZGJ3R3VML0thWVA5MzFpeDdLWmxXRmds?=
 =?utf-8?B?QXlOYTRIOUMxY0l6SlFmY3JaV0FxQkJIWUdqZmYzSDEvK1ZKV2JSa3NxRVlm?=
 =?utf-8?B?VUtSNW9DNk52MnlJKzI0S29GU3VCYVYrOHBEQXRZSjZqM3ZhbUpxNzgzbUxm?=
 =?utf-8?B?Z0FZTStlODh5bzlkdHZDclJVVlUvSGZrd2N0d3l5M3JNRUhmbGdNYUFzMkpF?=
 =?utf-8?B?RDNHUlFIeVYzbTRuQjNIRE03RzlUQUNFeDBvYnlMaEUxZytkc1k3ck4yR1l4?=
 =?utf-8?B?L0loMS9NZWwyMHNpOVc1a0dCei9Ibnp5N1dmV0RjWVVWSEt2Rzcrb2pVYVhW?=
 =?utf-8?B?dm1yZ3dlSnRhRWFNYlJOeDYwNzNNc2U2SGE5QWJUcVMzVGxFRlB5bld3a3Q0?=
 =?utf-8?B?L1J4NWRLa1ZpZld1YWxVWGpwZVZDZ1IrTm1kKzhRSmUvQmZ2MnYyWjJha3JU?=
 =?utf-8?B?dzJHVFJoN3hzRHl1VkphQXY1MURrWldJMWgwYzVGTFh6SnlOVzJHZGFoemlv?=
 =?utf-8?B?aXgrRGd1aW5DOWlxbTRJS2FIYnE4anRXN0hYcDliVTN3WUtWUDUya0dsQVJo?=
 =?utf-8?B?aEtNTmVMV2VBTjFFMm11VWlSaHZSRVBvMlBKSkV1ZW9heHF6eE1Hd2NDQ0Fx?=
 =?utf-8?B?MDVaVktXWDlJYWxxVlNCbGRXU2VrT2Q4YUhBRXgxTWU1R1Vzc05wZE9maStP?=
 =?utf-8?B?OUpLS1A2Y296dG52UHJtSEJFZG5GWlAraDZUT2dJZkxOVVc1byt2VWdITnpu?=
 =?utf-8?B?NWI4N1cxOFpUTS91eS9hNHppbU9GazRaVjVkVmhFdmRzZUsyOG1WYnkrRlFp?=
 =?utf-8?B?Q2M2ek9ocmN5YkIwcFlRMDJkRlJJRnU4YVZkWUIyaE5YRGRiWHR4MDRROWpX?=
 =?utf-8?B?VXlsSnhxSU1TM24zTkFlMFd5WUhjZm9MU0dxUEl4WGJxSDRvTU5wZjhuVXRK?=
 =?utf-8?B?c0pHd2kzbW5KT0FXTXd2UXA0TWJ0UUVzY29jakpIZXhkQlM4b0t0MjBYS1JQ?=
 =?utf-8?B?OUVjb3BibndYd3dNMGxLRnFhd0JQV0UyKytsRjF4VG01UjRJbWxuK0NIUkxx?=
 =?utf-8?B?blZVeFBObnUzN0kwa1pDd3VzMWtmbUZQM0VNWEcyR25udU1URGhUL2RMYjFl?=
 =?utf-8?B?bmc9PQ==?=
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR21MB3878.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb674ce0-b2ce-4f9f-175e-08dbc5dfb082
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2023 20:14:33.2291 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7Aw7o0yQRLdvgAE3XdRk+cnSQwaYuzUe4kwLqoVWuQINBFrARrEPAXmFEKo6Iy3y9n/MSCbJOpmbyIvE980KxMymoAewHCbyUPudtVTdTKA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR21MB3152
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/jKB2dl89sX_l_U1a7B-onO_lMp8>
Subject: Re: [Bpf] ISA RFC compliance question
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

PiBBbGV4ZWkgU3Rhcm92b2l0b3YgPGFsZXhlaS5zdGFyb3ZvaXRvdkBnbWFpbC5jb20+IHdyb3Rl
OiANCj4gT24gRnJpLCBTZXAgMjksIDIwMjMgYXQgMToxN+KAr1BNIERhdmUgVGhhbGVyDQo+IDxk
dGhhbGVyPTQwbWljcm9zb2Z0LmNvbUBkbWFyYy5pZXRmLm9yZz4gd3JvdGU6DQo+ID4gTm93IHRo
YXQgd2UgaGF2ZSBzb21lIG5ldyAidjQiIGluc3RydWN0aW9ucywgaXQgc2VlbXMgYSBnb29kIHRp
bWUgdG8NCj4gPiBhc2sgYWJvdXQgd2hhdCBpdCBtZWFucyB0byBzdXBwb3J0IChvciBjb21wbHkg
d2l0aCkgdGhlIElTQSBSRkMgb25jZQ0KPiA+IHB1Ymxpc2hlZC4gIERvZXMgaXQgbWVhbiB0aGF0
IGEgdmVyaWZpZXIvZGlzYXNzZW1ibGVyL0pJVCBjb21waWxlci9ldGMuIE1VU1QNCj4gc3VwcG9y
dCAqYWxsKiB0aGUNCj4gPiBub24tZGVwcmVjYXRlZCBpbnN0cnVjdGlvbnMgaW4gdGhlIGRvY3Vt
ZW50PyAgIFRoYXQgaXMgYW55IHJ1bnRpbWUgb3IgdG9vbCB0aGF0DQo+ID4gZG9lc24ndCBzdXBw
b3J0IHRoZSBuZXcgaW5zdHJ1Y3Rpb25zIGlzIGNvbnNpZGVyZWQgbm9uLWNvbXBsaWFudCB3aXRo
IHRoZSBCUEYNCj4gSVNBPw0KWy4uLl0NCj4gPiBPciBzaG91bGQgd2UgY3JlYXRlIHNvbWUgdGhp
bmdzIHRoYXQgYXJlIFNIT1VMRHMsIG9yIGZpbmVyIGdyYWluZWQNCj4gPiB1bml0cyBvZiBjb21w
bGlhbmNlIHNvIGFzIHRvIG5vdCBkZWNsYXJlIGV4aXN0aW5nIGRlcGxveW1lbnRzIG5vbi1jb21w
bGlhbnQ/DQo+IA0KPiBJIHN1c3BlY3QgJ25vbi1jb21wbGlhbmNlJyBsYWJlbCB3aWxsIGNhdXNl
IGFuIHVubmVjZXNzYXJ5IGJhY2tsYXNoLCBzbyBJIHdvdWxkDQo+IGdvIHdpdGggU0hPVUxEIHdv
cmRpbmcuDQoNClllYWgsIGJ1dCBpZiBlYWNoIGluc3RydWN0aW9uIGlzIGEgc2VwYXJhdGUgU0hP
VUxELCB0aGVuIGEgcnVudGltZSBjb3VsZCAoc2F5KQ0Kc3VwcG9ydCBvbmUgYXRvbWljIGluc3Ry
dWN0aW9uIGFuZCBub3Qgb3RoZXJzLiAgSGF2aW5nIHRoYXQgbGV2ZWwgb2YgZ3JhbnVsYXJpdHkN
CndvdWxkIHJlYWxseSBjb21wbGljYXRlIGludGVyb3BlcmFiaWxpdHkgYW5kIGNyb3NzLXBsYXRm
b3JtIHRvb2xpbmcgaW4gbXkgb3Bpbmlvbi4NClNvIGl0IG1pZ2h0IGJlIGJldHRlciB0byBsaXN0
IGdyb3VwcyBvZiBpbnN0cnVjdGlvbnMgYW5kIGhhdmUgdGhlIFNIT1VMRCBiZSBhdCB0aGUNCmdy
YW51bGFyaXR5IG9mIGEgZ3JvdXA/DQoNCkRhdmUNCi0tIApCcGYgbWFpbGluZyBsaXN0CkJwZkBp
ZXRmLm9yZwpodHRwczovL3d3dy5pZXRmLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2JwZgo=

