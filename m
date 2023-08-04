Return-Path: <bpf+bounces-6934-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E3776F838
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 05:06:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 197462823C5
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 03:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B30FA15C4;
	Fri,  4 Aug 2023 03:06:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814701101;
	Fri,  4 Aug 2023 03:06:22 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2085.outbound.protection.outlook.com [40.107.8.85])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F0B04EC8;
	Thu,  3 Aug 2023 20:06:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PWj7JAHmCDIRx+btn7i3unt0hqBy0Vm+3E4BHcy2w9u/WHw66bVQy7x9XQ3Z/fLvH9Qru9UsAyEbnxdi2XV4B2X2u02OEjvGvHrr+0lRC9iwWGdpu4Wi6e8lMY/2/2yiAoiiaSJbKxYbQs86jPZK1Ds7MagnGCHURWE2/IclVTEtox1R1K9ektaaMpOQyBjQ1E0PUDqAWRMmRBbRn0jkHfjwjjP5xOsnY/jRlqezHP907LoT70kcyZ3Zmdx5xC9809m72cyo49bxyk6qcKIynqiXjDy4nOGQrygJVct6iRBJaPH4NSmS57zq5J9BuNFJ6c1Fdhq7YE41rZVx1D/YNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y8eb7aAOseA524RoN8HQIOq2cMKFUxgFmgoY1uV0sUA=;
 b=RITiKAfh9lNFvMemicAGh1IRT6a8XuMAXHR7hSXqwtGkwv398Sj59rsYkv8OqDbeMpnagkQFzL6ben6e9tGdPEpUUee5REajd8WRTJR/1HulUBRsTiDIdTSiAJfsoPBx4byvbpvEDrJ5jvUzssDsWJaxs42DEv2anPmZ8QFEIv00yXhQBsOSsWUVLomqDTD/nEiw9QPrAeqtNOgXcTTXzL1rwz81cU+LiYgfFWFENM+ATfqvYa8zSlkrquTE7olizUEkfJoivkg3L+wVdxIrYIn+wjFcqveLLXM3XGqDtGb8ILktzrpiFKB1CJ0s6KkC1IBveQbtD9t6b2KhurkUdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y8eb7aAOseA524RoN8HQIOq2cMKFUxgFmgoY1uV0sUA=;
 b=pGizIrZ3SIy07TrIQp9Hs2pTrvMDzw1HdFO0RFafYYb6XC1EX56H8Op2GiK4pMOsdAzE6S7C/FJK/pmhq/Tv6Er2ZneaXFsNG0ZEKb9N9pQLk5qTCRC2jGvy2NBG3nGYD9nn6wLjgnc0qlXqGGTGgijsIAOnVdUkhqS8RRLyCO4=
Received: from AM5PR04MB3139.eurprd04.prod.outlook.com (2603:10a6:206:8::20)
 by DB8PR04MB6779.eurprd04.prod.outlook.com (2603:10a6:10:11b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Fri, 4 Aug
 2023 03:06:11 +0000
Received: from AM5PR04MB3139.eurprd04.prod.outlook.com
 ([fe80::2468:a15e:aa9b:7f8e]) by AM5PR04MB3139.eurprd04.prod.outlook.com
 ([fe80::2468:a15e:aa9b:7f8e%4]) with mapi id 15.20.6631.046; Fri, 4 Aug 2023
 03:06:11 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Jesper Dangaard Brouer <hawk@kernel.org>, Jesper Dangaard Brouer
	<jbrouer@redhat.com>, Jakub Kicinski <kuba@kernel.org>
CC: "brouer@redhat.com" <brouer@redhat.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>, "ast@kernel.org" <ast@kernel.org>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>, "john.fastabend@gmail.com"
	<john.fastabend@gmail.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, Andrew Lunn <andrew@lunn.ch>
Subject: RE: [PATCH V3 net-next] net: fec: add XDP_TX feature support
Thread-Topic: [PATCH V3 net-next] net: fec: add XDP_TX feature support
Thread-Index:
 AQHZw3VFF5NSBizeREOxLxVc18wksa/XS8kAgACl6SCAAEHAAIAAOPLAgAAgSoCAAOhtQA==
Date: Fri, 4 Aug 2023 03:06:11 +0000
Message-ID:
 <AM5PR04MB3139D8AAAB6B96B58425BBA08809A@AM5PR04MB3139.eurprd04.prod.outlook.com>
References: <20230731060025.3117343-1-wei.fang@nxp.com>
 <20230802104706.5ce541e9@kernel.org>
 <AM5PR04MB313985C61D92E183238809138808A@AM5PR04MB3139.eurprd04.prod.outlook.com>
 <1bf41ea8-5131-7d54-c373-00c1fbcac095@redhat.com>
 <AM5PR04MB31398ABF941EBDD0907E845B8808A@AM5PR04MB3139.eurprd04.prod.outlook.com>
 <cc24e860-7d6f-7ec8-49cb-a49cb066f618@kernel.org>
In-Reply-To: <cc24e860-7d6f-7ec8-49cb-a49cb066f618@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM5PR04MB3139:EE_|DB8PR04MB6779:EE_
x-ms-office365-filtering-correlation-id: 921fb525-46e6-4071-c6d6-08db9497c1ee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 HT1QhSULGu6J7Khdy+47ayv6oHX4nKUKRmIgU+7n/2TiG5t5qIkI8J5KwkIllnP5SbhfMxahiSAj1Do2ncaBtImqT/pvwMErh1TfKBlFbqi6AiEHoJTRmW3Q6ZgQ6yYD2OP+GZHMlSWFP2td3mT0h+kKZcKKVS1tPccL+g2WGbJE3uvKeGWN6H61QuxoiwykkdSV2sxJO7dOaMQDIq+NcYMSBi9ujnki6zX9ZhH+83jy8Yty0XBw3pocICDJwc0tlNxJqAW6xh65jwoF+2tiVuCtPgJz9Xv02QNYdY15RnlwhbjOkAHMktFUAymTqRDOfSASnZfDlo/Z0NzCGpTelal+AzvO8x3wAsHIDEWo0vW12LdAK/b4vJw+dmjfeplUlvu2G7iWxkWibufcOCzXpvpPr0mMTy0AjZbT5TERuBJ6KWI1avanuLGlqYRww4VsrXZQiw1T5bcHn63gJ+ja+c47wHoNFeI6UUTncu5jGJb6xO0phd79NzKlA0uTzCIJERnRrFhXOE3DP46MyUQUQYWbzcUXCXC65Jp/W36uTe9bq8COQ0Pd1M2BDAodA2YTWlmwoXA/cfqxNcpQAyWWk0aWpjAR+2qCziRbTC7rM14o2/cIOAl+TOfgY03Cjkeq
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM5PR04MB3139.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(39860400002)(366004)(136003)(396003)(451199021)(1800799003)(186006)(8676002)(26005)(6506007)(83380400001)(66476007)(2906002)(316002)(76116006)(4326008)(66946007)(5660300002)(66446008)(64756008)(66556008)(44832011)(8936002)(7416002)(41300700001)(7696005)(71200400001)(52536014)(9686003)(110136005)(478600001)(54906003)(55016003)(38100700002)(122000001)(33656002)(86362001)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?YdLhissh+3QIYrLkQ7jUMV1eMLq1Q1yDGsI39Ds0nr2zxRS/ruTFHlCHY7b+?=
 =?us-ascii?Q?XjdQ3/j8L5EVdKgySMxSAo08p7yeQbjTJ/8h24Ss0ELpq2iriDfObHLDRRdw?=
 =?us-ascii?Q?TC7Vyjm3j6I/j+BiyXIGAj1qFRGXnHBG+rMyGpabIHMa8WWmlczy3Mre1KWq?=
 =?us-ascii?Q?r4YtzMDwx72d0tg/WAfiwUil0GgVUbdWHkIQjTa+2hoG/S1xv1WAoGtu5Jsf?=
 =?us-ascii?Q?/9o7MpwbC9mK0dktQVjnwlZtPl6G5jne2ZCgDMqLtuSEBwIkulKzLQJkpVsb?=
 =?us-ascii?Q?KL51nMibyRjI0s6d/asGMOfg0t7Y+FT1G+KS5PPPy1SdA6vb9iGd0QLg+msZ?=
 =?us-ascii?Q?k4jzYwb9wFCjNeUCQl74CfCOd9tdvkOgu5mQ0dec0fh0jHCVXtF3aCr8CXsY?=
 =?us-ascii?Q?d1vzz4KzJrMLKz7frCyZiNMO2LlIJeLHsIzcQVTI4VpZxT6u2Ro0VQWuCx3L?=
 =?us-ascii?Q?DxbANDo93ZFV5SBzKVFf8UJ0GS5g+qj30hxvFK1C11Rn9pISO1Wwi+kCtWjK?=
 =?us-ascii?Q?dhnTLfpKho19sS1X4DJ4Zgj8g5ZUD+JPsweWJ6drrJnzF3/R+bkhG7cj+S6J?=
 =?us-ascii?Q?Pk5FJz/MjE4xdS2GbIwR9Fz4pX/cyrgnFzVw46Q6J38NcRJ9mdySXxwHZAhh?=
 =?us-ascii?Q?KZugJIgx3xxPgcScjcImUEu0Wd0Yil90YclblXmpcvz6/QJLWVhpt7rTrvIT?=
 =?us-ascii?Q?4iHw1F688UF/OaHD/zjWR8cdc5wTeUBLIGWWN3SMknP79qP9lmi7P1kJaa9Y?=
 =?us-ascii?Q?f6TbvJAZTrWFmR+ZUSgZBawSHdpRPukQsXilXKbAJRX3jDSQG2VDUVML/btB?=
 =?us-ascii?Q?CZocEhJgISCeM6odffMaJjv5WJ6WMetbr4s2njer5xmN5TppEBwPLAY66APh?=
 =?us-ascii?Q?rRi8hscbYdzWJDKd2Fc5umQHFoqA72Gkn3EcdeDYXT4vWgqocCgo1LD4ZIME?=
 =?us-ascii?Q?9HV58Gy1J5h/+KSTcQEcomZvJFFFPJjPLbnB+5/UgzBwGkddIyY0EKI3ssUg?=
 =?us-ascii?Q?GIjHExGE8sgbL56Q9xFBjEcOw+fPkEX19sF1PQ1RURv/GKb9V73Z2LZAFTd/?=
 =?us-ascii?Q?rWmIperSTMVFYXRDqHddJTv2YOhfXelVhDspVxVPqw5kfcglMWPPuiIWf+7n?=
 =?us-ascii?Q?wa9WQvbrjDN3Y9DMM3B127e2BO8rII4zW0g4VFdCHucoMItpHkU4KEhOflcI?=
 =?us-ascii?Q?IW3ScBOTfpEeZDUtqTQN+rd2z2cNAURiLNchpr0Nyh7xp2iI1Dw9BnDV/RW+?=
 =?us-ascii?Q?qXE1HEpMZzr4KJr3qdydlbLDlkf+038YQfrKGJGAHngSGOT2Z5V2kt0SfizQ?=
 =?us-ascii?Q?x3rw48llH3UfEgPmtDcYutUQkTLqBKsS+JYrQQmO0QBcLWfeZr65sTCsPNT7?=
 =?us-ascii?Q?NS+iNr9G9wReglYLgLJmg6kYqtnD3n4154SaHnW6rv8AmnY9a1qZKv4GZrFW?=
 =?us-ascii?Q?kKBbh0eIsEYNJzT2QEVo8L9CFgROMvusD5Oa+pR6vIziyQmet0FjauWN0wKV?=
 =?us-ascii?Q?x9zMSc6b3lxg/eZPLTiNFTyIAMydHPu872zZ94J1Pa5HzPBqrdcVk4pxalhr?=
 =?us-ascii?Q?FBsxAFR0WU1mQHZhN4U=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM5PR04MB3139.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 921fb525-46e6-4071-c6d6-08db9497c1ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2023 03:06:11.7387
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ICpL3GuoD7Do5XrJi4kOhMzJvYlzfT+yJoHgmXrSc/VxFctnzFEMlVpo5teQjWoRVFzknyIz7KB0TGostyvOIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6779
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> > The FEC of i.MX8MP-EVK has dma_coherent=3Dfalse, and as I mentioned
> > above, I did not see an obvious difference in the performance. :(
>=20
> That is surprising - given the results.
>=20
> (see below, lack of perf/diff might be caused by Ethernet flow-control).
>=20
> >
> >>> The result of the current modification.
> >>> root@imx8mpevk:~# ./xdp2 eth0
> >>> proto 17:     260180 pkt/s
> >>
> >> These results are*significantly*  better than reported in patch-1.
> >> What happened?!?
> >>
> > The test environment is slightly different, in patch-1, the FEC port
> > was directly connected to the port of another board. But in the latest
> > test, the ports of the two boards were connected to a switch, so the
> > ports of the two boards are not directly connected.
> >
>=20
> Hmm, I've seen this kind of perf behavior of direct-connected or via swit=
ch
> before. The mistake I made was, that I had not disabled Ethernet flow-con=
trol.
> The xdp2 XDP_TX program will swap the mac addresses, and send the packet
> back to the packet generator (running pktgen), which will get overloaded
> itself and starts sending Ethernet flow-control pause frames.
>=20
> Command line to disable:
>   # ethtool -A eth0 rx off tx off
>=20
> Can I ask/get you to make sure that Ethernet flow-control is disabled (on
> both generator and DUT (to be on safe-side)) and run the test again?
>=20
The flow-control was not disabled before, so according to your suggestion,
I disable the flow-control on the both boards and run the test again, the
performance is slightly improved, but still can not see a clear difference
between the two methods. Below are the results.

Result: use "sync_dma_len" method
root@imx8mpevk:~# ./xdp2 eth0
proto 17:     258886 pkt/s
proto 17:     258879 pkt/s
proto 17:     258872 pkt/s
proto 17:     258312 pkt/s
proto 17:     258926 pkt/s
proto 17:     259057 pkt/s
proto 17:     258437 pkt/s
proto 17:     259242 pkt/s
proto 17:     258665 pkt/s
proto 17:     258779 pkt/s
proto 17:     259209 pkt/s

Result: use the current method
root@imx8mpevk:~# ./xdp2 eth0
proto 17:     258752 pkt/s
proto 17:     258672 pkt/s
proto 17:     258317 pkt/s
proto 17:     258787 pkt/s
proto 17:     258757 pkt/s
proto 17:     258542 pkt/s
proto 17:     258829 pkt/s
proto 17:     258480 pkt/s
proto 17:     258859 pkt/s
proto 17:     258918 pkt/s
proto 17:     258782 pkt/s
proto 17:     259086 pkt/s
proto 17:     258337 pkt/s


