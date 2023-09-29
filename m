Return-Path: <bpf+bounces-11126-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ED467B3B0C
	for <lists+bpf@lfdr.de>; Fri, 29 Sep 2023 22:14:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 240E1283026
	for <lists+bpf@lfdr.de>; Fri, 29 Sep 2023 20:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB90666DFF;
	Fri, 29 Sep 2023 20:14:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C51FBF4
	for <bpf@vger.kernel.org>; Fri, 29 Sep 2023 20:14:25 +0000 (UTC)
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E87CD0
	for <bpf@vger.kernel.org>; Fri, 29 Sep 2023 13:14:18 -0700 (PDT)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id C1A8FC1522AF
	for <bpf@vger.kernel.org>; Fri, 29 Sep 2023 13:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1696018457; bh=i9R3y2Fa7l13WQVdSbXbaGt7gkPGST2SbxkbwuNV6pI=;
	h=To:CC:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=q7us5OMXzlm8AFORGxU4XZcZ5fZyhENrMMFYqUFEhxnDwN9Eiqv8QoXN094Gh5tbV
	 gvajjeRbsGxC4mgpXbHGrRMlQk3kogFCSG3S43eNaTvOtwKcWYYCdQtPMEoGwHO+nS
	 Z08MljBooToIKqmjS9F8FnGSR/16YZogPq6nhjKs=
Received: from ietfa.amsl.com (localhost [IPv6:::1])
 by ietfa.amsl.com (Postfix) with ESMTP id 87B1DC151556;
 Fri, 29 Sep 2023 13:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
 t=1696018457; bh=AMrLNcZB3INxXDAsGAYtg+RlsG7hEBuIne8tOiSm/b0=;
 h=From:To:CC:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
 List-Post:List-Help:List-Subscribe;
 b=Y+BENjJ/luoQUStiUeiuFHLeAzdYLD1+T6YJVbG3qmEtF5OlK4b/Wp6Ii9lLlbx5x
 Ow3GUKnv0+9RnlC/4g08IPS71ggB0n58TK8wFBqc6DQYaHE1taNBQIRIdcYkgSzbQF
 gqDo677f81MsJEqSzFOnZSg9wsUbP69jqi6xvwA8=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 3FBA3C151556
 for <bpf@ietfa.amsl.com>; Fri, 29 Sep 2023 13:14:16 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Score: -2.109
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HTML_MESSAGE,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (1024-bit key)
 header.d=microsoft.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bQzcy-6ymuFs for <bpf@ietfa.amsl.com>;
 Fri, 29 Sep 2023 13:14:15 -0700 (PDT)
Received: from BN3PR00CU001.outbound.protection.outlook.com
 (mail-eastus2azon11020027.outbound.protection.outlook.com [52.101.56.27])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 89AB5C15154E
 for <bpf@ietf.org>; Fri, 29 Sep 2023 13:14:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fDKkxf1jhqT5lBpqRvOG961/9WP5QNiQNzHgguIRPJubHFe/cR9pseeYZZiwdoDqv+D1Mt63zf0sbyiV0w/nO/JRpUmYTeIGKs1jUggv21262sAjYhcTNm0HTJV9t3HwE1Jo9NrlkpynCtxRiLiZLr6eXHGMSD5qGgVdHjpdzWk/NIHhiFRJ6vDdg2iW+iAbnhwN+o8FkgOE0k5jDO2Efzt9rc36y4GOe6fvRjBB0UQo6xTCh3wCl5sCDCFNJ7WoaBksX1Ju6uRgaK6R1PWSvXHMvflWhb59OrGuw2Ot1AWUVyrbL0gd8fxGC7v5Ks2Klb2FD+EMp9s5EPIuIefMXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iV+JXYaTZQuo9wG0y8CbnqjpHqwnm0uB8ZvE23+khig=;
 b=lbYj7DgKqYATIzAPigJyI3QwrKik4ONrzyDDWRcucGVcmJIvoiR5LiGc3eoTq4QNPWQ0G7TXcCvUozUvX5sgtVp+ooy46s6sk0+7f7HTvCw8KvjLTIzjW7PQKd0tacNtyCGjq1ueJIwMbrkyWbRocnys+fQq1D3mNCobNN3GxUknQ3GBSxQAvObGOrSa/Cn+iP/trRcgIFMDXbV7zFO+uyEnWFlH3jZ09XzjERB7mGWq0t3dQp1/kXpJ9A+0eT9UrI7MqzPNT3+zvxDmh9YnvJa2sHi7bc6VqHnQbFY7M58B4BNBKzA7wkeI7LSvoGnGRFmlKze+M0r3lEazrK6VIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iV+JXYaTZQuo9wG0y8CbnqjpHqwnm0uB8ZvE23+khig=;
 b=UDomawFEkoaZdeDeQi3WrSpOsCe7CRAlI8Qr0gOwzTr8AI7jP0JRVTJqbMTOf2yDHeUMQrcBTIMY53068FHm4BrmUMLs1LBRms4EdhiAes7LNUJBJvZllirWl/2UGf4jq5joadxQWCN3bS8vq4LKUL9wX6jSHSKPPy10yUWOZog=
Received: from PH7PR21MB3878.namprd21.prod.outlook.com (2603:10b6:510:243::22)
 by SJ0PR21MB2014.namprd21.prod.outlook.com (2603:10b6:a03:2aa::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.12; Fri, 29 Sep
 2023 20:14:12 +0000
Received: from PH7PR21MB3878.namprd21.prod.outlook.com
 ([fe80::ec5c:279e:7bfe:50e9]) by PH7PR21MB3878.namprd21.prod.outlook.com
 ([fe80::ec5c:279e:7bfe:50e9%3]) with mapi id 15.20.6838.010; Fri, 29 Sep 2023
 20:14:12 +0000
To: "bpf@ietf.org" <bpf@ietf.org>
CC: bpf <bpf@vger.kernel.org>
Thread-Topic: ISA RFC compliance question
Thread-Index: AdnzENHOvm4O8LpYSx6FMQlLag6r9Q==
Date: Fri, 29 Sep 2023 20:14:12 +0000
Message-ID: <PH7PR21MB387850B8DB6A2A5FB87DAC06A3C0A@PH7PR21MB3878.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=77ec43e0-99aa-49cd-b566-df416a63fa3f;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-09-29T20:08:55Z; 
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR21MB3878:EE_|SJ0PR21MB2014:EE_
x-ms-office365-filtering-correlation-id: 8f610284-edb0-4f04-102a-08dbc128a5b3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Tb34qvzN92MAQjK72c47aregYnh4wUEqsmI8lxeeEYQqGj1A3N0D83SvYQN/xYYV0+Syd+IXowC3k2B5yCnZ0kXM5IL8Ee5sfq9kk5hlPdl1pbuekp3G7cIhEfAc48q9uywHSLk8qzhB7M55anL/JQ12aoBLQYjnpcS03A3haWszS/X8V/SiQkBWeIBB7cjTcn0DikogWRJJ0K71mq6DGwlDB3KNu3ZMnPqtMgX3YF5WguMH83dwNa/425wH18FLvLjtFXjIEy0i/RT5PpWkMEUOKHU80xRHf+Yl7u5vjHd9ey2yzYJBVofJ9wUri8CgSIAxlHx3B7pdmwzLvNuTL08wnaAKlVYe2hz5QQhBKTkvcsngU8SUdzqTHGKeu1AoQeWlEf9GJaq+3QUlJOwXkg76d51CKepiCb4GUum8ORlpPSGYnCJQ6/G8vrs1TBNLztKmsqiWTor4bRetVgoNvQLY5FM2Visu9OsccsnEseuQnuHKiupvS+g73YTCWvPaK7BEnSEc2jOYVOQR5nZ15cfPeyHTHvRJQbPOrP/7FjxtaBxbX9bYaoGQRTHcYcefjBJJXt8GM2J6BcgxEdk8U+tVRSTrA1bQSD8aanwT2nLXb9gTIAGev9Z0K6JWeYmhm8isV213nLDKZcg1n762lpEBw328Rvgpw0+WhjIa44o=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:; 
 IPV:NLI; SFV:NSPM;
 H:PH7PR21MB3878.namprd21.prod.outlook.com; PTR:; CAT:NONE; 
 SFS:(13230031)(136003)(39860400002)(396003)(366004)(346002)(376002)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(4744005)(52536014)(2906002)(5660300002)(4326008)(8990500004)(55016003)(316002)(41300700001)(6916009)(64756008)(66446008)(76116006)(66946007)(66476007)(66556008)(8936002)(8676002)(478600001)(10290500003)(6506007)(7696005)(9686003)(71200400001)(3480700007)(26005)(82960400001)(38070700005)(122000001)(38100700002)(82950400001)(33656002)(86362001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5SyIsGW0BYUl1wNw5HzIdsBFOqmr9FUVPkMtPPDyTJfvOoVaEMH9HgP2t34V?=
 =?us-ascii?Q?hpD1FUQhhix01xnx+5/I0Gq/Hk8wrttxbHC0buEejVJc0gYA36x+r0XQgGBk?=
 =?us-ascii?Q?jj6dZzxx6eCnmw8uRKGCd/CS05LyQ6y7PLqZFPOpwopdTYu9r+2LUOqz1P1j?=
 =?us-ascii?Q?Rn7oiNZcazSfqx7a2YXwnKGm5X9x6q9qq+N9Y9nb989SyKepMEM+ASmQSRI3?=
 =?us-ascii?Q?+1G1iYrL71VeTKWYC6byChKGARDxfM3Og3mo3X7ofSP1qmR+trx84NXh4iH2?=
 =?us-ascii?Q?npxiV/sEzbBtVcBw2O/v6hrWzRbHquNN5AY+/9AuuZ5YoeLf4nwVNocp8FR1?=
 =?us-ascii?Q?uBnoxLYGSFZPKE4cOEmD+Iu+cslTq9jhw5li+bRkoFRz4s4QeB05TGX+s4Fe?=
 =?us-ascii?Q?H2nWiIkKn4N9q15H6HLN9CNg2SjEFrtyqlPY7QMr5Ev8APsImuXn5zQOzIRm?=
 =?us-ascii?Q?Q/hxxR4mS83LnZeJOesaMc0w+uvPV+hl2nbmaMPC346GvDN6SfOgxGiOEghJ?=
 =?us-ascii?Q?5s0/Vgb1VmWz895/Q5iX7Mj4wuEEPpQMN8fh2pQObQ9yVokuLaAg1wzK1qDn?=
 =?us-ascii?Q?EgnkeJERP6FKT1hrhB3WGs2y6L5eWryxM8cerweLNtrMdvAGBiR7PHM36WOu?=
 =?us-ascii?Q?LQa01e/wdoOLluZc/GGVe/3BEzSE+V3fPYQg+y2lkjEb1LqDJwRDsHS2IaNq?=
 =?us-ascii?Q?pZbGN+T/lTR8zGKjwk0wJFmNPbcRKukfpYHntSwA3Tr0pUMEiq/41n0/KR9P?=
 =?us-ascii?Q?vX8E+Tg/R5AJ4KXK2r8F1GKjzNEyP9NZl2ca2mMNRqFutMbbicPmmnu1ZSMQ?=
 =?us-ascii?Q?MkYnyeY0D+KLOpn9bzs5oaR1jCicC+zGprJrbTqMBa1ZmPNmwmetHMD2A9Pf?=
 =?us-ascii?Q?JsZGQClzr0PVtUFQUylHohnrKOLDA3HqUNtOFmTIQtTf5DQFQwBbBC2eZ2Aw?=
 =?us-ascii?Q?JJAf6PfwkfdMP9STGq5DINQEfIzM06qR23WBE0olbODOMnwKJHBBwK1SfYRX?=
 =?us-ascii?Q?C0D+cxkIvlfo3NPVW8ttr8mfIMydab80r8nYPkxo1wzrIY7lIYt78kKLmTHo?=
 =?us-ascii?Q?HIh4DkQuEjCPxg7KivaNx6BGmGoGQe7Buc4nOqiFskBesh09MpMN+lSi6tqR?=
 =?us-ascii?Q?jxG9bfC7L4YG1p1oCvNT6AWvEv6fPjD37veAuO6soPcsmB+Vzc+myn7OvlP5?=
 =?us-ascii?Q?4v9YKhjbnbogHOLMRAAbgFxkAOo3Qk/3uClNfQSHc5KVm46D/3VHRgZQBZQ2?=
 =?us-ascii?Q?2V1bsb5YjQtE2ZgNcyL3mxlhZDA9Azxslcj+qgaL5Q5Iz5CPkJmZSmhVflsF?=
 =?us-ascii?Q?i6vnAXTAyFd90gMG2qJMm5d80j8CqR8chL76GIht85ppTjsx+Nx4Q75q4jjG?=
 =?us-ascii?Q?UQjmuAHr2RNeOvilyh6pX+6/uq9C0iDLoRQ72IiYM6Tl4jZNJgay5DYwmZ0N?=
 =?us-ascii?Q?1KEqOr4FhW1TAz9gLwE2dKBLsphEQyzE2cgPSWQmc90ufpv/CYWAIJZEg8Mv?=
 =?us-ascii?Q?vZ93nzzO7ryoxCJcvyEBXH+3+l9DRdc5WBOsUxi+O6h19dmt9ogW/bCXJ80v?=
 =?us-ascii?Q?SsgE2c4DT0BnjugVhz5DUweK5Pmn+D042FU8rA14eCK2TfVH/nDQacz+18me?=
 =?us-ascii?Q?gg=3D=3D?=
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR21MB3878.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f610284-edb0-4f04-102a-08dbc128a5b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2023 20:14:12.5752 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UuqPgogOTHtHKsSzmk5R0ZVywNMVmkHH5JZg+WHTBAi7EfCu4tTWISihZqfhYz9vTU/+OddlcbtEqNMm9fh2MkwCny0DtgbQKno7bs9vWS4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR21MB2014
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/e1orttgAjbEdMjwUiQ2HRYip0nQ>
Subject: [Bpf] ISA RFC compliance question
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
Content-Type: multipart/mixed; boundary="===============2164832258133213471=="
Errors-To: bpf-bounces@ietf.org
Sender: "Bpf" <bpf-bounces@ietf.org>
X-Original-From: Dave Thaler <dthaler@microsoft.com>
From: Dave Thaler <dthaler=40microsoft.com@dmarc.ietf.org>
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

--===============2164832258133213471==
Content-Language: en-US
Content-Type: multipart/alternative;
 boundary="_000_PH7PR21MB387850B8DB6A2A5FB87DAC06A3C0APH7PR21MB3878namp_"

--_000_PH7PR21MB387850B8DB6A2A5FB87DAC06A3C0APH7PR21MB3878namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Now that we have some new "v4" instructions, it seems a good time to ask ab=
out
what it means to support (or comply with) the ISA RFC once published.  Does
it mean that a verifier/disassembler/JIT compiler/etc. MUST support *all* t=
he
non-deprecated instructions in the document?   That is any runtime or tool =
that
doesn't support the new instructions is considered non-compliant with the B=
PF ISA?

Or should we create some things that are SHOULDs, or finer grained units of
compliance so as to not declare existing deployments non-compliant?
Previously we only talked about cases where instructions were added in an
extension RFC which would naturally provide a separate RFC to conform to.
But I don't think we discussed things like new instructions in the main spe=
c like
we have now.

Dave

--_000_PH7PR21MB387850B8DB6A2A5FB87DAC06A3C0APH7PR21MB3878namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Aptos;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Aptos",sans-serif;
	mso-ligatures:standardcontextual;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Aptos",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:11.0pt;
	font-family:"Aptos",sans-serif;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#467886" vlink=3D"#96607D" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Now that we have some new &#8220;v4&#8221; instructi=
ons, it seems a good time to ask about<o:p></o:p></p>
<p class=3D"MsoNormal">what it means to support (or comply with) the ISA RF=
C once published.&nbsp; Does<o:p></o:p></p>
<p class=3D"MsoNormal">it mean that a verifier/disassembler/JIT compiler/et=
c. MUST support *<b>all</b>* the<br>
non-deprecated instructions in the document?&nbsp;&nbsp; That is any runtim=
e or tool that<br>
doesn&#8217;t support the new instructions is considered non-compliant with=
 the BPF ISA?<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Or should we create some things that are SHOULDs, or=
 finer grained units of<br>
compliance so as to not declare existing deployments non-compliant?<o:p></o=
:p></p>
<p class=3D"MsoNormal">Previously we only talked about cases where instruct=
ions were added in an<br>
extension RFC which would naturally provide a separate RFC to conform to.<o=
:p></o:p></p>
<p class=3D"MsoNormal">But I don&#8217;t think we discussed things like new=
 instructions in the main spec like<br>
we have now.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Dave<o:p></o:p></p>
</div>
</body>
</html>

--_000_PH7PR21MB387850B8DB6A2A5FB87DAC06A3C0APH7PR21MB3878namp_--


--===============2164832258133213471==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

--===============2164832258133213471==--


